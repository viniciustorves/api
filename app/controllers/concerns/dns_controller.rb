# README + @TODO:
#
# This is a super highly primitive implementation of what
# our REST functionality for DNS products will look like
#
# Because the jellyfish db schema is in a state of flux
# for products, we will abstract the dns models here
#
# Some considerations must be made about whether to expand
# or make changes to fog-*dns gems or make those changes
# in the jellyfish-fog-*dns module
#
# cluo comments: I feel like pdns' api stuff is out of the norm
# how to reconcile its weirdness with a more typical dns provider?

class DnsController < ApplicationController
  after_action  :verify_authorized
  after_action  :post_hook

  before_action :pre_hook

  # Only pdns needs server_id?... Hm

  api :GET, ':server_id/zones', 'Returns a collection of zones'
  param :server_id, required: true

  def index
    #respond
  end

  api :GET, ':server_id/zones/:zone_id', 'Shows zone with :id'
  param :server_id, required: true
  param :zone_id, required: true

  def show
    #respond
  end

  api :POST, ':server_id/zones', 'Create zone with :name'
  param :server_id, required: true
  param :name, required: true
  param :nameservers, required: true # this is only required for pdns, how to reconcile?

  def create
    #respond
  end

  api :DELETE, ':server_id/zones/zone:id', 'Delete zone with :zone_id'
  param :server_id, required: true
  param :zone_id, required: true

  def delete
    #respond
  end

  api :PUT, ':server_id/zones/zone:id', 'Modify zone with :zone_id'
  param :server_id, required: true
  param :zone_id, required: true
  # @TODO: test if this requires the entire structure

  def modify
    # In modular:
    # if requires the entire structure:
    # Authorize
    # do GET on zone
    # populate with old fields
    # update new fields
    # respond
  end

  api :PATCH, ':server_id/zones/zone:id', 'Modify records of :zone_id'
  param :server_id, required: true
  param :zone_id, required: true
  # @TODO: need rrset structure

  def update_records
    # Making changes to records is all done through this REST endpoint
    # See powerdns docs for specifics
  end

  api :GET, ':server_id/zones/zone:id', 'Show records of :zone_id'
  param :server_id, required: true
  param :zone_id, required: true
  # @TODO: need rrset structure
  # For pdns you view rrsets by GETing the zone...
  # e.g. GET(zone).response[rrsets]
  # See powerdns docs for specifics

  def show_records
    #
  end


end