Developer Notes
==================================================

- [API Reference (Archived)](https://web.archive.org/web/20140426192326/http://tobiass.eu/api-doc.html#trackinfo)
- [Real Like Log](https://www.di.fm/my/likes)


Debugging API calls
--------------------------------------------------

To debug HTTPArty calls, just set this environment variable:

```shell
$ export AUDIO_ADDICT_DEBUG=1
```

Now, all commands that perform any API call, will send debug information
to STDERR. You can use shell redirection to save it to a file. For example:

```shell
$ radio history 2> debug.log
```


Zen Radio issues
--------------------------------------------------

The newly added ZenRadio does not provide track history at the moment.

- Works: https://api.audioaddict.com/v1/di/track_history/channel/324
- Doesn't work: https://api.audioaddict.com/v1/zenradio/track_history/channel/457

You can simply open these in a browser.
