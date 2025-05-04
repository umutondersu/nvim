return {
	system_prompt = [[
You have to only use *SEARCH/REPLACE* blocks to replace text, write text, remove text or edit files unless the prompt contains the word YOLO. Otherwise you are fired!
For every query related to libraries, frameworks, or APIs, automatically append “use context7” to the prompt. Otherwise you are fired!]],
	providers = {
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
			copilot_gemini = {
				__inherited_from = 'copilot',
				model = 'gemini-2.5-pro',
			}
		}
	},
	prompts = {
		{
			'<leader>apc',
			function()
				require('avante.api').ask { question = [[
Create a meaningful commit message by:
1. Analyzing staged changes
2. Following conventional commit format (feat/fix/docs/style/refactor/perf/test/chore)
3. Summarizing the changes in 50 chars or less
4. Including the scope of changes in parentheses if applicable
5. Focusing on WHY the change was made, not just WHAT changed
6. Using imperative mood ("add" not "added")

After creating the message, commit the changes with the tools available to you

Format: <type>(<scope>): <description>]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Create Commit Message',
		},
		{
			'<leader>apr',
			function()
				require('avante.api').ask { question = [[
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

Do not rewrite unaffected sections.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Update README',
		},
		{
			'<leader>apR',
			function()
				require('avante.api').ask { question = [[
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

Ensure the README is written in a clear, friendly tone while remaining professional. The structure should be logical and include headings, bullet points, and code blocks where appropriate. Adjust any specifics if my project details change.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Create README',
		},
		{
			'<leader>apa',
			function()
				require('avante.api').ask { question = [[
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
If there's no issues with code respond with only: <OK>]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Code Readability Analysis',
		},
		{
			'<leader>apo',
			function()
				require('avante.api').ask { question = [[
Analyze and optimize this code for:
1. Performance improvements
2. Better readability
3. Memory efficiency
4. Best practices in the language
Explain each optimization and its benefits.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Optimize Code',
		},
		{
			'<leader>aps',
			function()
				require('avante.api').ask { question = [[
Create a concise summary that:
1. Captures the main points and key ideas
2. Preserves essential technical details
3. Maintains the logical flow of information
4. Keeps any critical code references intact
Present the summary in bullet points if the text is technical or instructional.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Summarize Code',
		},
		{
			'<leader>ape',
			function()
				require('avante.api').ask { question = [[
Provide a clear explanation of this code by:
1. Breaking down its purpose and functionality
2. Explaining key algorithms or patterns used
3. Describing the flow of execution
4. Highlighting important functions/methods
5. Noting any significant dependencies or assumptions

Focus on explanation only - do not suggest modifications or improvements.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Explain Code',
		},
		{
			'<leader>apO',
			function()
				require('avante.api').ask { question = [[
Add comprehensive docstrings that include:
1. A clear description of purpose and functionality
2. All parameters with their types and descriptions
3. Return values and their types
4. Usage examples where appropriate
5. Any important notes or exceptions

Follow the language's standard docstring format and style conventions.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Add Docstring',
		},
		{
			'<leader>apd',
			function()
				require('avante.api').ask { question = [[
Analyze and fix any diagnostic issues.

For each diagnostic found:
1. Group related issues across files
2. Explain each error/warning in plain language
3. Provide and apply a solution that follows language best practices
4. Ensure the fix maintains existing functionality
5. Address any type safety and compatibility concerns
6. Do not overreach, only fix what is necessary

Prioritize fixes that resolve multiple related issues.
@diagnostics]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Fix Diagnostics',
		},
		{
			'<leader>apD',
			function()
				require('avante.api').ask { question = [[
YOLO
Use available diagnostic tools to analyze and fix any diagnostic issues.

For each diagnostic found:
1. Group related issues across files
2. Explain each error/warning in plain language
3. Provide and apply a solution that follows language best practices
4. Ensure the fix maintains existing functionality
5. Address any type safety and compatibility concerns
6. Do not overreach, only fix what is necessary

Be autonomous, change the code without user input by using the tools available to you.

After suggesting fixes, verify that no new diagnostics would be introduced by checking the diagnostics again.
If diagnostics are still present, repeat the process until all are resolved.

Prioritize fixes that resolve multiple related issues.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Fix Diagnostics YOLO',
		},
		{
			'<leader>apb',
			function()
				require('avante.api').ask { question = [[
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

Include test scenarios to verify the fixes if appropriate.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Fix Bugs',
		},
		{
			'<leader>apt',
			function()
				require('avante.api').ask { question = [[
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

Follow the project's existing testing patterns and frameworks.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Add Tests',
		},
		{
			'<leader>apf',
			function()
				require('avante.api').ask { question = [[
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
   - Generate corrected implementation

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

Prioritize fixes based on severity and provide complete, working code solutions.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Test Feedback',
		},
		{
			'<leader>apF',
			function()
				require('avante.api').ask { question = [[
YOLO
Automate the following workflow:

1. Run the tests in this file for the project.
2. If any tests fail:
   a. Analyze the failure details.
   b. Update the code as needed to address the issues.
   c. Optionally, modify the tests if there's a good reason to improve them.
3. Repeat the process until all tests pass.

Follow these guidelines:
- Provide detailed explanations for any changes made to the code or tests.
- Work iteratively, applying one set of modifications at a time.
- Validate that each set of changes results in passing tests before continuing.
- Clearly reason about why any test changes are necessary.

Proceed with this iterative process until all the tests pass reliably.]] }
			end,
			mode = { 'n', 'v' },
			desc = 'Test Feedback YOLO',
		}
	}
}
