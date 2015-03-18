require 'parse-ruby-client'

# It really doesn't seem to be a terribly good idea having the api_key exposed to anyone
# but that seems to be how they're doing things. See
# https://data.sa.gov.au/storage/f/2014-06-25T01%3A10%3A05.960Z/parse-api-instruction-document-unleashed-v2.pdf

Parse.init :application_id => "LvLKTxvA2LGOTJAXTZhblO4E1f04miKymXsHRGaO",
           :api_key        => "gOVgfFHKJviaYhujxhH7kc9T9KoFmsrjwLvlSEqo",
           :quiet          => false

contacts = Parse::Query.new("contact").get
contacts.each do |contact|
  query = Parse::Query.new("council")
  query.eq("councilId", contact["ownerId"])
  council = query.get.first

  record = {
    "name" => contact["name"],
    "position" => contact["position"],
    "updated_at" => contact["updatedAt"],
    "url" => contact["url"],
    "council" => council["name"],
    "council_url" => council["website"],
    "ward" => contact["ward"]
  }
  p record
end