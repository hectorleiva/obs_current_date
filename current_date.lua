-- Show the current date with a prefix and/or suffix
-- Author: Hector Leiva (hex@hectorleiva)
-- Version 1.0

--[[
Usage:
    Prefix: Current Date: YYYY-MM-DD
    Suffix: YYYY-MM-DD is the current date
    Prefix & Suffix: Current Date: YYYY-MM-DD is the current date
--]]

obs = obslua

source_name = ""
prefix = ""
suffix = ""

-- Loads all the settings possible for the script
function script_properties()
    local props = obs.obs_properties_create()
    
    -- (obs_properties, setting id, description(localized name shown to user), type, format)
    local p = obs.obs_properties_add_list(props, "source", "Text Source", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
    local sources = obs.obs_enum_sources()

    -- As long as the sources are not empty, then
    if sources ~= nil then
        -- iterate over all the sources
        for _, source in ipairs(sources) do
            source_id = obs.obs_source_get_id(source)
            if source_id == "text_gdiplus" or source_id == "text_ft2_source" or source_id == "text_gdiplus_v2" or source_id == "text_ft2_source_v2" then
                local name = obs.obs_source_get_name(source)
                obs.obs_property_list_add_string(p, name, name)
            end
        end
    end

    obs.source_list_release(sources)

    obs.obs_properties_add_text(props, "prefix", "Prefix Text", obs.OBS_TEXT_DEFAULT)
    obs.obs_properties_add_text(props, "suffix", "Suffix Text", obs.OBS_TEXT_DEFAULT)
    
    return props
end

-- script_defaults will be called to set the initial default settings
function script_defaults(settings)
    obs.obs_data_set_default_string(settings, "prefix", prefix)
    obs.obs_data_set_default_string(settings, "suffix", suffix)
end

-- script_update will be called when settings are changed
function script_update(settings)
    source_name = obs.obs_data_get_string(settings, "source")
    prefix = obs.obs_data_get_string(settings, "prefix")
    suffix = obs.obs_data_get_string(settings, "suffix")
end

-- script_load will be called whenever a new source is created
function script_load(settings)
    local sh = obs.obs_get_signal_handler()
    obs.signal_handler_connect(sh, "source_activate", source_activated)
end

function source_activated(cd)
    activate_plugin(cd)
end

-- Called when this source is activated
function activate_plugin(cd)
    local source = obs.calldata_source(cd, "source")
    if source ~= nil then
        local name = obs.obs_source_get_name(source)
        if (name == source_name) then
            activate()
        end
    end
end

function activate()
    set_current_date_text()
end

function set_current_date_text()
    local date_string_text = os.date('%Y-%m-%d')

    if prefix ~= '' or prefix ~= nil then
        date_string_text = prefix .. ' ' .. date_string_text
    end

    if suffix ~= '' or suffix ~= nil then
        date_string_text = date_string_text .. ' ' .. suffix
    end

    local source = obs.obs_get_source_by_name(source_name)

    if source ~= nil then
        local settings = obs.obs_data_create()
        obs.obs_data_set_string(settings, "text", date_string_text)
        obs.obs_source_update(source, settings)
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    end
end
