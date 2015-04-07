def mock
  ::Fog.mock!
end

def unmock
  ::Fog.unmock!
end

!%w(production staging).include? Rails.env ? mock : unmock