local HealthCheck = {
	log = {},
}

function HealthCheck:init()
	self.started = true
	self.errors = {}

	vim.cmd([[
  augroup UserHealthCheck
  au!
  au SourcePre * lua require 'user.health':mark_started(<afile>)
  au SourcePre * echo 'sourcing...' . <afile>
  augroup END
  ]])
end

function HealthCheck:finish()
	vim.api.nvim_del_augroup_by_name("UserHealthCheck")
	for file, status in pairs(self.files) do
		print('failed to source file "%s"')
	end
end

function HealthCheck:mark_started(file)
	self.loading[file] = true
end

function HealthCheck:mark_returned_succ(file)
	self.loading[file] = nil
end

function HealthCheck:mark_fail(file, message)
	self.errors[file] = message
end

-- logging

function HealthCheck.log:warn(msg)
	vim.list_extend(self, { msg })
end

function HealthCheck.check()
	for _, msg in ipairs(HealthCheck.log) do
		vim.health.report_warn(msg)
	end
end

return HealthCheck
