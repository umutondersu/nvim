return {
	claude = {
		endpoint = "https://api.anthropic.com",
		model = "claude-3-5-sonnet-20241022",
		timeout = 30000,
		temperature = 0,
		max_tokens = 4096,
	},
	copilot = { model = 'claude-3.5-sonnet' },
	gemini = { model = 'gemini-2.5-pro-exp-03-25' },
	vendors = {
		groq = {
			__inherited_from = "openai",
			api_key_name = "GROQ_API_KEY",
			endpoint = "https://api.groq.com/openai/v1/",
			model = "deepseek-r1-distill-llama-70b"
		},
	},
}
