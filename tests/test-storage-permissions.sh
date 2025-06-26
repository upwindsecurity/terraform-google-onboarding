#!/bin/bash

# GCP Permissions Test Script
# Usage: ./test_permissions.sh [ORG_ID] [PROJECT_ID] [BUCKET_NAME] [OBJECT_NAME]

# Requires local gcloud auth to the service account under test

set -e

# Configuration
ORG_ID=${1:-"532401344755"}
PROJECT_ID=${2:-"upwindsecurity-xa"}
BUCKET_NAME=${3:-"adamh-test-hns"}
OBJECT_NAME=${4:-"test.txt"}

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Symbols
TICK="✓"
CROSS="✗"

# Function to test a permission
test_permission() {
    local permission_name="$1"
    local command="$2"
    
    printf "%-50s " "$permission_name"
    
    if eval "$command" >/dev/null 2>&1; then
        echo -e "${GREEN}${TICK}${NC}"
        return 0
    else
        echo -e "${RED}${CROSS}${NC}"
        return 1
    fi
}

# Function to check if required parameters are provided
check_params() {
    if [[ -z "$ORG_ID" ]]; then
        echo -e "${RED}Error: Organization ID required${NC}"
        echo "Usage: $0 [ORG_ID] [PROJECT_ID] [BUCKET_NAME] [OBJECT_NAME]"
        exit 1
    fi
}

# Header
echo -e "${BLUE}GCP Permissions Test${NC}"
echo "==================="
echo

# Check required parameters
check_params

# Initialize counters
passed=0
total=0

echo -e "${BLUE}Testing Resource Manager Permissions...${NC}"
# resourcemanager.projects.get
if [[ -n "$PROJECT_ID" ]]; then
    if test_permission "resourcemanager.projects.get" "gcloud projects describe $PROJECT_ID"; then
        ((passed++))
    fi
else
    echo -e "resourcemanager.projects.get                      ${RED}SKIPPED (no PROJECT_ID)${NC}"
fi
((total++))

# resourcemanager.projects.list
if test_permission "resourcemanager.projects.list" "gcloud projects list --limit=1"; then
    ((passed++))
fi
((total++))
echo

echo -e "${BLUE}Testing Storage Bucket Permissions...${NC}"
# storage.buckets.list
if test_permission "storage.buckets.list" "gcloud storage buckets list --limit=1"; then
    ((passed++))
    # If no bucket provided, try to get one from the list
    if [[ -z "$BUCKET_NAME" ]]; then
        BUCKET_NAME=$(gcloud storage buckets list --limit=1 --format="value(name)" 2>/dev/null | head -1)
    fi
fi
((total++))

if [[ -n "$BUCKET_NAME" ]]; then
    # storage.buckets.get
    if test_permission "storage.buckets.get" "gcloud storage buckets describe gs://$BUCKET_NAME"; then
        ((passed++))
    fi
    ((total++))

    # storage.buckets.getIamPolicy
    if test_permission "storage.buckets.getIamPolicy" "gcloud storage buckets get-iam-policy gs://$BUCKET_NAME"; then
        ((passed++))
    fi
    ((total++))

    # storage.buckets.getIpFilter
    if test_permission "storage.buckets.getIpFilter" "gcloud storage buckets describe gs://$BUCKET_NAME --format='value(ipFilter)'"; then
        ((passed++))
    fi
    ((total++))

    # storage.buckets.getObjectInsights
    if test_permission "storage.buckets.getObjectInsights" "gcloud storage insights inventory-reports list --source=gs://$BUCKET_NAME --limit=1"; then
        ((passed++))
    fi
    ((total++))

else
    echo -e "storage.buckets.get                               ${RED}SKIPPED (no buckets found)${NC}"
    echo -e "storage.buckets.getIamPolicy                      ${RED}SKIPPED (no buckets found)${NC}"
    echo -e "storage.buckets.getIpFilter                       ${RED}SKIPPED (no buckets found)${NC}"
    echo -e "storage.buckets.getObjectInsights                 ${RED}SKIPPED (no buckets found)${NC}"
    echo -e "storage.buckets.listEffectiveTags                 ${RED}SKIPPED (no buckets found)${NC}"
    echo -e "storage.buckets.listTagBindings                   ${RED}SKIPPED (no buckets found)${NC}"
    total=$((total + 6))
fi
echo

echo -e "${BLUE}Testing Storage Operations Permissions...${NC}"
# storage.bucketOperations.list
if test_permission "storage.bucketOperations.list" "gcloud storage operations list --limit=1 projects/_/buckets/$BUCKET_NAME"; then
    ((passed++))
    # Try to get an operation ID for the get test
    OPERATION_ID=$(gcloud storage operations list --limit=1 --format="value(name)" 2>/dev/null | head -1)
fi
((total++))

# storage.bucketOperations.get
if [[ -n "$OPERATION_ID" ]]; then
    if test_permission "storage.bucketOperations.get" "gcloud storage operations describe $OPERATION_ID"; then
        ((passed++))
    fi
else
    echo -e "storage.bucketOperations.get                      ${RED}SKIPPED (no operations found)${NC}"
fi
((total++))
echo

echo -e "${BLUE}Testing Storage Folders Permissions...${NC}"
if [[ -n "$BUCKET_NAME" ]]; then
    # storage.folders.list
    if test_permission "storage.folders.list" "gcloud storage folders list gs://$BUCKET_NAME/ --limit=1"; then
        ((passed++))
        # Try to get a folder for the get test
        FOLDER_NAME=$(gcloud storage folders list gs://$BUCKET_NAME/ --limit=1 --format="value(name)" 2>/dev/null | head -1)
    fi
    ((total++))

    # storage.folders.get
    if [[ -n "$FOLDER_NAME" ]]; then
        if test_permission "storage.folders.get" "gcloud storage folders describe gs://$BUCKET_NAME/$FOLDER_NAME"; then
            ((passed++))
        fi
    else
        echo -e "storage.folders.get                               ${RED}SKIPPED (no folders found)${NC}"
    fi
    ((total++))
else
    echo -e "storage.folders.list                              ${RED}SKIPPED (no bucket)${NC}"
    echo -e "storage.folders.get                               ${RED}SKIPPED (no bucket)${NC}"
    total=$((total + 2))
fi
echo

echo -e "${BLUE}Testing Storage Managed Folders Permissions...${NC}"
if [[ -n "$BUCKET_NAME" ]]; then
    # storage.managedFolders.list
    if test_permission "storage.managedFolders.list" "gcloud storage managed-folders list gs://$BUCKET_NAME/ --limit=1"; then
        ((passed++))
        # Try to get a managed folder for other tests
        MANAGED_FOLDER=$(gcloud storage managed-folders list gs://$BUCKET_NAME/ --limit=1 --format="value(name)" 2>/dev/null | head -1)
    fi
    ((total++))

    # storage.managedFolders.get
    if [[ -n "$MANAGED_FOLDER" ]]; then
        if test_permission "storage.managedFolders.get" "gcloud storage managed-folders describe gs://$BUCKET_NAME/$MANAGED_FOLDER"; then
            ((passed++))
        fi
        # storage.managedFolders.getIamPolicy
        if test_permission "storage.managedFolders.getIamPolicy" "gcloud storage managed-folders get-iam-policy gs://$BUCKET_NAME/$MANAGED_FOLDER"; then
            ((passed++))
        fi
    else
        echo -e "storage.managedFolders.get                        ${RED}SKIPPED (no managed folders)${NC}"
        echo -e "storage.managedFolders.getIamPolicy               ${RED}SKIPPED (no managed folders)${NC}"
    fi
    total=$((total + 2))
else
    echo -e "storage.managedFolders.list                       ${RED}SKIPPED (no bucket)${NC}"
    echo -e "storage.managedFolders.get                        ${RED}SKIPPED (no bucket)${NC}"
    echo -e "storage.managedFolders.getIamPolicy               ${RED}SKIPPED (no bucket)${NC}"
    total=$((total + 3))
fi
echo

echo -e "${BLUE}Testing Storage Objects Permissions...${NC}"
if [[ -n "$BUCKET_NAME" ]]; then
    # storage.objects.list
    if test_permission "storage.objects.list" "gcloud storage objects list gs://$BUCKET_NAME/ --limit=1"; then
        ((passed++))
        # If no object provided, try to get one from the list
        if [[ -z "$OBJECT_NAME" ]]; then
            OBJECT_NAME=$(gcloud storage objects list gs://$BUCKET_NAME/ --limit=1 --format="value(name)" 2>/dev/null | head -1)
        fi
    fi
    ((total++))
else
    echo -e "storage.objects.list                              ${RED}SKIPPED (no bucket)${NC}"
    ((total++))
fi

# Summary
echo
echo -e "${BLUE}Summary${NC}"
echo "======="
echo -e "Passed: ${GREEN}$passed${NC}/$total"

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}All permissions working correctly!${NC}"
    exit 0
else
    failed=$((total - passed))
    echo -e "${RED}$failed permission(s) failed or were skipped${NC}"
    exit 1
fi
