local log = hs.logger.new('init.lua', 'debug')

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind({'ctrl'}, '`', nil, function()
  hs.reload()
end)

keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

-- super = {"cmd", "alt", "ctrl"}

-- NOTE this is a mess / placeholder
-- There are from `elliotwaite/hammerspoon-config`
-- These constants are used in the code below to allow hotkeys to be
-- Assigned using side-specific modifier keys.
-- ORDERED_KEY_CODES = {58, 61, 55, 54, 59, 62, 56, 60}
-- KEY_CODE_TO_KEY_STR = {
--   [58] = 'leftAlt',
--   [61] = 'rightAlt',
--   [55] = 'leftCmd',
--   [54] = 'rightCmd',
--   [59] = 'leftCtrl',
--   [62] = 'rightCtrl',
--   [56] = 'leftShift',
--   [60] = 'rightShift',
-- }
-- KEY_CODE_TO_MOD_TYPE = {
--   [58] = 'alt',
--   [61] = 'alt',
--   [55] = 'cmd',
--   [54] = 'cmd',
--   [59] = 'ctrl',
--   [62] = 'ctrl',
--   [56] = 'shift',
--   [60] = 'shift',
-- }
-- KEY_CODE_TO_SIBLING_KEY_CODE = {
--   [58] = 61,
--   [61] = 58,
--   [55] = 54,
--   [54] = 55,
--   [59] = 62,
--   [62] = 59,
--   [56] = 60,
--   [60] = 56,
-- }

-- SIDE_SPECIFIC_HOTKEYS:
--     This table is used to setup my side-specific hotkeys, the format
--     of each entry is: {fromMods, fromKey, toMods, toKey}
--
--     fromMods (string):
--         Any of the following strings, joined by plus signs ('+'). If
--         multiple are used, they must be listed in the same order as
--         they appear in this list (alphabetical by modifier name, and
--         then left before right):
--             leftAlt
--             rightAlt
--             leftCmd
--             rightCmd
--             leftCtrl
--             rightCtrl
--             leftShift
--             rightSfhit
--
--     fromKey (string):
--         Any single-character string, or the name of a keyboard key.
--         The list keyboard key names can be found here:
--         https://www.hammerspoon.org/docs/hs.keycodes.html#map
--
--     toMods (string):
--         Any of the following strings, joined by plus signs ('+').
--         Unlike `fromMods`, the order of these does not matter:
--             alt
--             cmd
--             ctrl
--             shift
--             fn
--
--     toKey (string):
--         Same format as `fromKey`.
--

-- SIDE_SPECIFIC_HOTKEYS = {
--   {'rightCmd', nil, 'ctrl+alt+cmd'}
-- }


require('keyboard.control-escape')
require('keyboard.delete-words')
require('keyboard.hyper')
require('keyboard.markdown')
require('keyboard.microphone')
require('keyboard.panes')
require('keyboard.windows')

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
