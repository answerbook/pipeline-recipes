resource "mezmo_pipeline" "simple_field_parser" {
  title       = "Example Recipe"
}

// Create a simple HTTP source that receives data from a webhook
resource "mezmo_http_source" "http_source" {
  pipeline_id = mezmo_pipeline.simple_field_parser.id
  title       = "My HTTP source"
  description = "This receives data from my webhook"
  decoding    = "json"
}

// Create a simple field parser that parses the data received from the HTTP source
resource "mezmo_parse_processor" "error_logs" {
  pipeline_id = mezmo_pipeline.simple_field_parser.id
  title       = "Apache parser"
  description = "Parse apache logs"
  inputs      = [mezmo_http_source.http_source.id]
  field       = ".log"
  parser      = "apache_log"
  apache_log_options = {
    format           = "error"
    timestamp_format = "%Y/%m/%d %H:%M:%S"
  }
}

// Create a destination that sends the parsed logs to Mezmo Log Analysis
resource "mezmo_logs_destination" "destination1" {
  pipeline_id   = mezmo_pipeline.simple_field_parser.id
  title         = "My destination"
  description   = "Send logs to Mezmo Log Analysis"
  inputs        = [mezmo_parse_processor.error_logs.id]
  ingestion_key = var.mezmo_ingestion_key
}