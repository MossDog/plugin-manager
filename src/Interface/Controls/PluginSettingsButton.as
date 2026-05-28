namespace Controls
{
	bool HasSettings(Meta::Plugin@ plugin)
	{
		return plugin !is null && plugin.GetSettings().Length > 0;
	}

	void PluginSettingsButton(PluginInfo@ plugin)
	{
		auto installedPlugin = plugin.GetInstalledPlugin();
		bool hasSettings = HasSettings(installedPlugin);
		bool isLoaded = installedPlugin !is null;
		UI::BeginDisabled(!isLoaded || !hasSettings);
		if (UI::Button(Icons::Cogs + " Settings")) {
			Meta::OpenSettings(installedPlugin);
		}
		UI::EndDisabled();

		if (!isLoaded) {
			UI::SetItemTooltip("This plugin isn't currently loaded.");
		} else if (!hasSettings) {
			UI::SetItemTooltip("This plugin doesn't have any settings.");
		}
	}
}
