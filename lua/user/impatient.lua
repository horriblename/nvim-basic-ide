local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  require 'user.health':warn('failed to load lua module "impatient"')
  return
end

impatient.enable_profile()
