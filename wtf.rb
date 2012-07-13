#
# Author:: Joan Touzet (<joant@cloudant.com>)
# Copyright:: Copyright (c) 2012 Cloudant, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provides 'wtf'

require 'json'
require 'rest-client'

url = 'http://ipv4.wtfismyip.com/json'

begin
  response = RestClient.get(url)
  results = JSON.parse(response)
  
  if not results.nil?
    wtf Mash.new
    if not results['YourFuckingIPAddress'].nil?
      wtf[:ismyip] = results['YourFuckingIPAddress']
    end
    if not results['YourFuckingLocation'].nil?
      wtf[:ismylocation] = results['YourFuckingLocation']
    end
  end

rescue RestClient::Exception
  Ohai::Log.debug("wtfismyip lookup failed.")
end

