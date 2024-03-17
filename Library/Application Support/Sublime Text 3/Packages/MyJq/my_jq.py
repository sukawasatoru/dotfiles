import json
import sublime
import sublime_plugin


def plugin_loaded():
	print("my_jq: Hello")
	# {"Hello": "world"}


def plugin_unloaded():
	print("my_jq: Bye")

# view.run_command("my_jq")
class MyJqCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		# get selection and ignore multiple selection (e.g. ⌘ + Drag)
		sel = self.view.sel()[0]

		selected_text = self.view.substr(sel)

		try:
			json_object = json.loads(selected_text)
			pretty_json = json.dumps(json_object, indent=2)
			self.view.replace(edit, sel, pretty_json)
			print(pretty_json)
		except json.decoder.JSONDecodeError as err:
			self.view.replace(edit, sel, f"failed: {err=}")
