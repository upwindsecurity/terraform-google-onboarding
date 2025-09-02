# resource "google_project_service" "pubsub" {
#   service = "pubsub.googleapis.com"
#   disable_on_destroy = false
#   disable_dependent_services = false
# }

# resource "google_project_service" "logging" {
#   service = "logging.googleapis.com"
#   disable_on_destroy = false
#   disable_dependent_services = false
# }

# # Create Pub/Sub topic for instance events
# resource "google_pubsub_topic" "instance_events" {
#   name = "instance-events"
  
#   depends_on = [google_project_service.pubsub]
# }

# # Create subscription to read from
# resource "google_pubsub_subscription" "instance_events_sub" {
#   name  = "instance-events-subscription"
#   topic = google_pubsub_topic.instance_events.name

#   # Keep messages for 7 days
#   message_retention_duration = "604800s"
  
#   # Give us 60 seconds to process each message
#   ack_deadline_seconds = 60
# }

# # Create organization-level log sink to capture instance lifecycle events across all projects
# resource "google_logging_organization_sink" "instance_sink" {
#   name         = "org-instance-lifecycle-sink"
#   org_id       = var.gcp_organization_id
#   destination  = "pubsub.googleapis.com/projects/${var.upwind_orchestrator_project}/topics/${google_pubsub_topic.instance_events.name}"

#   # Filter for compute instance start/stop/create/delete events across the organization
#   filter = <<-EOT
#     resource.type="gce_instance"
#     AND (
#       protoPayload.methodName="v1.compute.instances.start"
#       OR protoPayload.methodName="v1.compute.instances.stop" 
#       OR protoPayload.methodName="v1.compute.instances.insert"
#       OR protoPayload.methodName="v1.compute.instances.delete"
#     )
#   EOT

#   # Include children (folders and projects under the organization)
#   include_children = true
  
#   depends_on = [google_project_service.logging]
# }

# # Grant the organization log sink permission to publish to our topic
# resource "google_pubsub_topic_iam_member" "log_writer" {
#   topic  = google_pubsub_topic.instance_events.name
#   role   = "roles/pubsub.publisher"
#   member = google_logging_organization_sink.instance_sink.writer_identity
# }

# # Output the subscription name for our Go program
# output "subscription_name" {
#   value = google_pubsub_subscription.instance_events_sub.name
# }