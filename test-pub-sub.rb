# topic_id = "your-topic-id"
require "google/cloud/pubsub"

pubsub = Google::Cloud::Pubsub.new

topic = pubsub.topic topic_id
topic.publish "This is a test message."

puts "Message published."
