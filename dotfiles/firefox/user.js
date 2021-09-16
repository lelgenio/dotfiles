/* {{@@ header() @@}}
 _____ _           __
|  ___(_)_ __ ___ / _| _____  __
| |_  | | '__/ _ \ |_ / _ \ \/ /
|  _| | | | |  __/  _| (_) >  <
|_|   |_|_|  \___|_|  \___/_/\_\
*/

// scroll pixel by pixel holding Alt
user_pref("mousewheel.system_scroll_override_on_root_content.enabled", true);
user_pref("mousewheel.with_alt.action", 1);
user_pref("mousewheel.with_alt.delta_multiplier_y", 5);

// don't show menu bar on Alt
user_pref("ui.key.menuAccessKeyFocuses", false);

user_pref("general.autoScroll", true);
user_pref("devtools.inspector.three-pane-enabled", false);

user_pref("security.dialog_enable_delay", 0);
user_pref("browser.discovery.enabled", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.startup.homepage", "about:blank");

// browser.startup.page
// Possible values are:
//  0 => Blank page (Legacy)
//  1 => Follow setting on Home panel for Home page
//  2 => Last visited page (Legacy)
//  3 => Restore previous session
user_pref("browser.startup.page", 3);

// compact density
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);

// don't save passwords
user_pref("signon.rememberSignons", false);

// Disable the redesign
user_pref("browser.proton.contextmenus.enabled", false);
user_pref("browser.proton.doorhangers.enabled", false);
user_pref("browser.proton.enabled", false);
user_pref("browser.proton.modals.enabled", false);

// Enalbe custom css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Ui customization
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[\"ublock0_raymondhill_net-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"addon_darkreader_org-browser-action\",\"tab-session-manager_sienori-browser-action\",\"fxa-toolbar-menu-button\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"chrome-gnome-shell_gnome_org-browser-action\",\"_contain-facebook-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"_e4a8a97b-f2ed-450b-b12d-ee082ba24781_-browser-action\",\"_48748554-4c01-49e8-94af-79662bf34d50_-browser-action\",\"tab-session-manager_sienori-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"widget-overflow-fixed-list\"],\"currentVersion\":17,\"newElementCount\":5}");
user_pref("browser.tabs.drawInTitlebar", false);

user_pref("devtools.chrome.enabled", true);
user_pref("devtools.command-button-measure.enabled", true);
user_pref("devtools.command-button-rulers.enabled", true);
user_pref("devtools.dom.enabled", true);

user_pref("devtools.editor.keymap", "emacs");
user_pref("devtools.editor.tabsize", 4);
user_pref("devtools.inspector.activeSidebar", "ruleview");
user_pref("devtools.inspector.three-pane-enabled", false);
user_pref("devtools.responsive.leftAlignViewport.enabled", true);
user_pref("devtools.theme", "dark");

// hardware acceleration
user_pref("media.ffmpeg.vaapi.enabled", "true");
user_pref("media.ffvpx.enabled", "false");
user_pref("media.rdd-vpx.enabled", "false");
user_pref("gfx.webrender.compositor.force-enabled", "true");
