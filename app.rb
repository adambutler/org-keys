require 'sinatra'
require 'open-uri'
require 'json'

get '/' do
  """
  Usage /:organization
  """
end

get '/:organization' do
  url = "https://api.github.com/orgs/#{params['organization']}/members"
  members = JSON.parse(open(url).read)

  keys = """
#
# #{params['organization']} keys
# #{url}
#
# --
"""

  for member in members.map{ |member| member['login'].downcase }.sort
    member_keys = "https://github.com/#{member}.keys"

    info = """
#
# @#{member}
# #{member_keys}
#
"""

    keys += info + open(member_keys).read.gsub(/\r\n?/, "\n")
  end

  keys
end
