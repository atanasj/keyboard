local log = hs.logger.new('delete-words.lua', 'debug')

local isInTerminal = function()
   app = hs.application.frontmostApplication():name()
   return app == 'iTerm2' or app == 'Terminal' 
end

local isInEmacs = function()
   app = hs.application.frontmostApplication():name()
   return app == 'Emacs' or app == 'Alacritty'
end


-- Use option + h to delete previous word
hs.hotkey.bind({'alt'}, 'h', function()
      -- If we're in the terminal, then temporarily disable our custom control+k
      -- hotkey used for pane navigation, then fire control+k to delete to the end
      -- of the line, and then renable the control+k hotkey.
      --
      -- If we're not in the terminal, then just select to the end of the line and
      -- then delete the selected text.
      if isInTerminal() then
    hotkeyForAltH = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey_AltH)
      return hotkey_AltH.idx == '⌃W'
    end)
    if hotkeyForAltH then hotkeyForAltH:disable() end

    keyUpDown({'ctrl'}, 'w')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey.
    hs.timer.doAfter(0.2, function()
      if hotkeyForAltH then hotkeyForAltH:enable() end
    end)
      elseif isInEmacs() then
         hotkeyForAltH2 = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey2_AltH)
      return hotkey2_AltH.idx == '⌥H'
    end)
    if hotkeyForAltH2 then hotkeyForAltH2:disable() end

    keyUpDown({'alt'}, 'h')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey2.
    hs.timer.doAfter(0.2, function()
      if hotkeyForAltH2 then hotkeyForAltH2:enable() end
    end)
      else
    keyUpDown({'alt'}, 'delete')
  end
end)

-- Use option + l to delete next word
hs.hotkey.bind({'alt'}, 'l', function()
      -- If we're in the terminal, then temporarily disable our custom control+k
      -- hotkey used for pane navigation, then fire control+k to delete to the end
      -- of the line, and then renable the control+k hotkey.
      --
      -- If we're not in the terminal, then just select to the end of the line and
      -- then delete the selected text.
      if isInTerminal() then
    hotkeyForAltL = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey_AltL)
      return hotkey_AltL.idx == 'escape D'
    end)
    if hotkeyForAltL then hotkeyForAltL:disable() end

    keyUpDown({}, 'escape')
    keyUpDown({}, 'd')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey.
    hs.timer.doAfter(0.2, function()
      if hotkeyForAltL then hotkeyForAltL:enable() end
    end)
      elseif isInEmacs() then
         hotkeyForAltL2 = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey2_AltL)
      return hotkey2_AltL.idx == '⌥L'
    end)
    if hotkeyForAltL2 then hotkeyForAltL2:disable() end

    keyUpDown({'alt'}, 'l')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey2.
    hs.timer.doAfter(0.2, function()
      if hotkeyForAltL2 then hotkeyForAltL2:enable() end
    end)
      else
    keyUpDown({'alt'}, 'forwarddelete')
  end
end)

-- Use control + u to delete to beginning of line
--
-- In bash, control + u automatically deletes to the beginning of the line, so
-- we don't need (or want) this hotkey in the terminal. If this hotkey was
-- enabled in the terminal, it would break the standard control + u behavior.
-- Therefore, we only enable this hotkey for non-terminal apps.
local wf = hs.window.filter.new():setFilters({iTerm2 = false, Terminal = false, Emacs = false})
enableHotkeyForWindowsMatchingFilter(wf, hs.hotkey.new({'ctrl'}, 'u', function()
  keyUpDown({'cmd'}, 'delete')
end))

-- Use control + ; to delete to end of line
--
-- I prefer to use control+h/j/k/l to move left/down/up/right by one pane in all
-- multi-pane apps (e.g.,or app == 'Terminal' iTerm, various editors). That's convenient and
-- consistent, but it conflicts with the default macOS binding for deleting to
-- the end of the line (i.e., control+k). To maintain that very useful
-- functionality, and to keep it on the home row, this hotkey binds control+; to
-- delete to the end of the line.

hs.hotkey.bind({'ctrl'}, ';', function()
      -- If we're in the terminal, then temporarily disable our custom control+k
      -- hotkey used for pane navigation, then fire control+k to delete to the end
      -- of the line, and then renable the control+k hotkey.
      --
      -- If we're not in the terminal, then just select to the end of the line and
      -- then delete the selected text.
      if isInTerminal() then
    hotkeyForControlK = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey)
      return hotkey.idx == '⌃K'
    end)
    if hotkeyForControlK then hotkeyForControlK:disable() end

    keyUpDown({'ctrl'}, 'k')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey.
    hs.timer.doAfter(0.2, function()
      if hotkeyForControlK then hotkeyForControlK:enable() end
    end)
      elseif isInEmacs() then
         hotkeyForControlK2 = hs.fnutils.find(hs.hotkey.getHotkeys(), function(hotkey2)
      return hotkey2.idx == '⌃;'
    end)
    if hotkeyForControlK2 then hotkeyForControlK2:disable() end

    keyUpDown({'ctrl'}, ';')

    -- Allow some time for the control+k keystroke to fire asynchronously before
    -- we re-enable our custom control+k hotkey2.
    hs.timer.doAfter(0.2, function()
      if hotkeyForControlK2 then hotkeyForControlK2:enable() end
    end)
      else
    keyUpDown({'cmd', 'shift'}, 'right')
    keyUpDown({}, 'forwarddelete')
  end
end)
