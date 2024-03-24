local function command_exists(command)
  local handle = io.popen("command -v " .. command)
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

return {
  command_exists = command_exists,
}
