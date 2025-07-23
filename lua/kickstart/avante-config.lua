return {
	system_prompt = [[
For every query related to libraries, frameworks, or APIs, automatically append “use context7” to the prompt. Otherwise you are fired!
Before making changes on an existing file, view It so that you can modify them without error. Otherwise You are fired!]],
	providers = {
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-5-sonnet-20241022",
			timeout = 30000,
			extra_request_body = {
				temperature = 0,
				max_tokens = 4096
			}
		},
		gemini = { model = 'gemini-2.5-pro' },
		groq = {
			__inherited_from = "openai",
			api_key_name = "GROQ_API_KEY",
			endpoint = "https://api.groq.com/openai/v1/",
			model = "deepseek-r1-distill-llama-70b"
		},
		copilot_claude = {
			__inherited_from = 'copilot',
			model = 'claude-sonnet-4',
			context_window = 200000,
		},
		copilot_gemini = {
			__inherited_from = 'copilot',
			model = 'gemini-2.5-pro',
			context_window = 1000000,
		},
		moonshot = {
			__inherited_from = 'openai',
			api_key_name = 'MOONSHOT_API_KEY',
			endpoint = 'https://api.moonshot.ai/v1',
			model = 'kimi-k2-0711-preview',
			context_window = 131072
		}
	},
	shortcuts = {
		{
			name = "commit",
			description = "Create Commit Message",
			details = "Creates a meaningful commit message",
			prompt = [[
Create a meaningful commit message by:
1. Analyzing staged changes
2. Following conventional commit format (feat/fix/docs/style/refactor/perf/test/chore)
3. Summarizing the changes in 50 chars or less
4. Including the scope of changes in parentheses if applicable
5. Focusing on WHY the change was made, not just WHAT changed
6. Using imperative mood ("add" not "added")

After creating the message, commit the changes with the tools available to you

Format: <type>(<scope>): <description>]]
		},
		{
			name = "readmeupdate",
			description = "Update README",
			details = "Updates README.md based on the latest changes by changes",
			prompt = [[
Update README.md based on the latest changes:
1. Analyze staged changes (or unstaged if none staged)
2. Identify sections that need updating based on changes:
   - New features or functionality
   - Changed behaviors or interfaces
   - Updated dependencies or requirements
   - Modified configuration options
3. Maintain existing README structure and style
4. Keep updates concise but informative
5. Include any new code examples if relevant
6. Update version numbers if applicable

Do not rewrite unaffected sections.]]
		},
		{
			name = "readmecreate",
			description = "Create README",
			details = "Generates a comprehensive README.md for the project",
			prompt = [[
Please generate a comprehensive README for my project in Markdown format in the root folder of the project. Use the tools in your disposal the have context about the project. Below are the details I’d like included:

1. **Overview:**
   - A brief description of the project, its purpose, and the problems it solves.
   - The intended audience and key benefits.

2. **Features:**
   - A bullet list of the main features and functionalities.

3. **Installation:**
   - Detailed setup instructions including prerequisites.
   - Step-by-step commands or guidelines required to install dependencies and run the project.

4. **Usage:**
   - Examples of common use cases with code snippets.
   - Instructions on how to run tests (if applicable).

If necessary, add other sections that you think could be important for the README.

Ensure the README is written in a clear, friendly tone while remaining professional. The structure should be logical and include headings, bullet points, and code blocks where appropriate. Adjust any specifics if my project details change.]]
		},
		{
			name = "readability",
			description = "Code Readability Analysis",
			details = "Identifies readability issues in a code snippet",
			prompt = [[
You must identify any readability issues in the code snippet.
Some readability issues to consider:
- Unclear naming
- Unclear purpose
- Redundant or obvious comments
- Lack of comments
- Long or complex one liners
- Too much nesting
- Long variable names
- Inconsistent naming and code style.
- Code repetition

You may identify additional problems. The user submits a small section of code from a larger file.
Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
If there's no issues with code respond with only: <OK>]]
		},
		{
			name = "optimize",
			description = "Optimize Code",
			details = "Analyzes and optimizes code for performance, memory efficiency, and best practices",
			prompt = [[
Analyze and optimize this code for:
1. Performance improvements
2. Better readability
3. Memory efficiency
4. Best practices in the language
Explain each optimization and its benefits.]]
		},
		{
			name = "summarize",
			description = "Summarize Code",
			details = "Creates a concise summary of the code, capturing main points, technical details",
			prompt = [[
Create a concise summary that:
1. Captures the main points and key ideas
2. Preserves essential technical details
3. Maintains the logical flow of information
4. Keeps any critical code references intact
Present the summary in bullet points if the text is technical or instructional.]]
		},
		{
			name = "explain",
			description = "Explain Code",
			details = "Provide a clear explanation of the code by breaking down its purpose",
			prompt = [[
Provide a clear explanation of this code by:
1. Breaking down its purpose and functionality
2. Explaining key algorithms or patterns used
3. Describing the flow of execution
4. Highlighting important functions/methods
5. Noting any significant dependencies or assumptions

Focus on explanation only - do not suggest modifications or improvements.]]
		},
		{
			name = 'docstring',
			description = 'Add Docstring',
			details = 'Add comprehensive docstrings',
			prompt = [[
Add comprehensive docstrings that include:
1. A clear description of purpose and functionality
2. All parameters with their types and descriptions
3. Return values and their types
4. Usage examples where appropriate
5. Any important notes or exceptions

For each issue found:
- Explain the bug's impact and potential risks
- Provide a clear fix that follows best practices
- Verify the fix doesn't introduce new issues
- Consider performance and side effects
Follow the language's standard docstring format and style conventions.]]
		},
		{
			name = 'diagnosticsfix',
			description = 'Fix Diagnostics',
			details = 'Analyzes diagnostics, selectively fixing important issues',
			prompts = [[
Analyze diagnostics and selectively fix important issues.

Skip: stylistic warnings, minor linting, intentional patterns (unused vars in prototypes)
Fix: genuine errors, critical warnings, functionality issues, type safety problems

For selected fixes:
1. Group related issues, explain in plain language
2. Apply best practices while maintaining functionality
3. Address type safety concerns without overreaching
4. Prioritize fixes that resolve multiple issues meaningfully]]
		},
		{
			name = 'bugfix',
			description = 'Fix Bugs',
			details = 'Analyzes code for potential bugs, and provides clear fixes',
			prompt = [[
Analyze the code for potential bugs and issues:
1. Check for logical errors and edge cases
2. Identify potential runtime errors
3. Look for common pitfalls in the language/framework
4. Analyze error handling and validation
5. Review type safety and data validation
6. Review security vulnerabilities

For each issue found:
- Explain the bug's impact and potential risks
- Provide a clear fix that follows best practices
- Verify the fix doesn't introduce new issues
- Consider performance and side effects
- Suggest preventive measures for similar bugs

Include test scenarios to verify the fixes if appropriate.]]
		},
		{
			name = "testadd",
			description = "Add Tests",
			details = "Generate comprehensive tests",
			prompt = [[
Generate comprehensive tests that:
1. Cover core functionality
   - Happy path scenarios with realistic input data
   - Edge cases (empty, null, maximum values)
   - Error conditions and exception handling
   - Boundary value analysis
   - Input validation across all data types
   - Expected outputs with detailed assertions

2. Follow testing best practices
   - Clear test descriptions
   - Isolated test cases
   - Meaningful assertions
   - Proper setup and teardown

3. Include different test types
   - Unit tests
   - Integration tests where needed
   - Error handling tests
   - Performance tests if relevant

4. Consider test coverage
   - Key functionality paths
   - Edge cases
   - Error conditions
   - Common use cases

Follow the project's existing testing patterns and frameworks.]]
		},
		{
			name = "testfeedback",
			description = "Test Feedback",
			details = "Analyze test results and provide structured feedback with fixes",
			prompt = [[
Analyze the test results and provide structured feedback with fixes:
1. Summary of test execution
   - Total tests run/passed/failed
   - Critical failures or blocking issues
   - Performance-related concerns

2. For each failing test:
   - Root cause analysis
   - Code path that triggered the failure
   - Expected vs actual behavior
   - PROVIDE DIRECT CODE FIXES with explanations
   - Generate corrected implementatio#bugfixn

3. Pattern Analysis & Fixes:
   - Common failure themes with code-level solutions
   - Areas needing more test coverage with example tests
   - Fix architectural issues with refactoring suggestions
   - Resolve performance bottlenecks with optimized code

4. Implementation of Fixes:
   - Provide ready-to-use code fixes
   - Include error handling improvements
   - Add missing edge case handling
   - Implement test suite enhancements

Prioritize fixes based on severity and provide complete, working code solutions.]]
		},
	}
}
