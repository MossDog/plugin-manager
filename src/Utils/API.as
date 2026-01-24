namespace API
{
	Net::HttpRequest@ Get(const string &in path)
	{
		if (!path.StartsWith("/")) {
			throw("API request path does not start with a slash!");
		}

		auto ret = Net::HttpRequest();
		ret.Method = Net::HttpMethod::Get;
		ret.Url = Setting_ApiBaseUrl + path;
		if (Setting_VerboseLog) {
			trace("API request: " + ret.Url);
		}
		ret.Start();
		return ret;
	}

	Json::Value GetAsync(const string &in path)
	{
		auto req = Get(path);
		while (!req.Finished()) {
			yield();
		}
		return Json::Parse(req.String());
	}
}
