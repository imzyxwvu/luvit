--[[

Copyright 2014 The Luvit Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

--]]
local utils = require('utils')
local uv = require('uv')

exports.name = "creationix/luvit-globals"
exports.version = "0.0.1"

local function init()
  -- Make print go through libuv for windows colors
  _G.print = utils.print
  -- Register global 'p' for easy pretty printing
  _G.p = utils.prettyPrint
  _G.process = require('process').globalProcess()
end

local function run()

  -- Start the event loop
  uv.run()
  require('hooks'):emit('process.exit')
  uv.run()

  -- When the loop exits, close all uv handles.
  uv.walk(uv.close)
  uv.run()
end

exports.init = init
exports.run = run
