local uv = require('uv');

local co
co = coroutine.create(function (filename)

  print("opening...")
  uv.fs_open(filename, 'r', "0644", resume)
  local fd = coroutine.yield()
  p("on_open", {fd=fd})

  print("reading...")
  uv.fs_read(fd, 0, 4096, resume)
  local chunk, length = coroutine.yield()
  p("on_read", {chunk=chunk, length=length})

  print("closing...")
  uv.fs_close(fd, resume)
  coroutine.yield()
  p("on_close")

end)

function resume(...)
  coroutine.resume(co, ...)
end

resume("license.txt")
