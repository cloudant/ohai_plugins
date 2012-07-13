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

provides 'kernel/sysctl'
require_plugin 'kernel'

kernel[:sysctl] = Mash.new unless kernel[:sysctl]

cmd = Chef::ShellOut.new("sysctl -A")
cmd.run_command
cmd.stdout.each_line do |line|
  fullkey, value = line.split(/[=:]/, 2).map {|i| i.strip}
  next if fullkey.nil?
  keys = fullkey.split('.')
  last = keys.pop
  cur = kernel[:sysctl]
  keys.each do |key|
    cur[key] ||= {}
    cur = cur[key]
  end
  cur[last] = value
end
