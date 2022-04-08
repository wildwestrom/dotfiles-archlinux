#!/usr/bin/wpexec

--[[
    Generic audio interface splitting code

    Currently only for the Motu M4 is implemented
  ]]

input_devs  = {}
output_devs = {}

-- Generic functions
function generic_stereo_output_loopback_device(node, internal_name, unique_identifier, node_description, group_index, input_channel_map, output_channel_map)
    left_channel_index  = (group_index*2)+1
    right_channel_index = (group_index*2)+2

    input_left   = input_channel_map[left_channel_index]
    input_right  = input_channel_map[right_channel_index]

    local full_internal_name = string.format("%s_%d_%d", internal_name, left_channel_index, right_channel_index)
    local full_node_description = string.format("%s %d/%d (%s)", node_description, left_channel_index, right_channel_index, unique_identifier)

    local module_params = string.format(
        [[
        node.name = "%s"
        node.description = "%s"
        capture.props = {
            node.name        = "%s_Capture"
            node.description = "%s"
            media.class = Audio/Sink
            audio.position = [FL,FR]
        }
        playback.props = {
            node.name     = "%s_Playback"
            node.description = "%s"
            audio.position = [ %s, %s ]
            node.target = "%s"
            node.passive = false
            stream.dont-remix = true
        }
        ]],
        full_internal_name,
        full_node_description,
        full_internal_name,
        full_node_description,
        full_internal_name,
        full_node_description,
        input_left, input_right,
        node.properties['node.name']
    )
    -- print(module_params)
    return LocalModule("libpipewire-module-loopback", module_params)
    -- return module_params
end

function generic_mono_input_loopback_device(node, internal_name, unique_identifier, node_description, channel_index, input_channel_map, output_channel_map)
    input_channel_name  = input_channel_map[channel_index]
    output_channel_name = output_channel_map[channel_index]

    local full_internal_name = string.format("%s_%s", internal_name, output_channel_name)
    local full_node_description = string.format("%s %s (%s)", node_description, output_channel_name, unique_identifier)

    local module_params = string.format(
        [[
        node.name        = "%s"
        node.description = "%s"

        capture.props = {
            node.target = %s
            audio.position = [%s]
            node.passive = true
            stream.dont-remix = true
            node.name        = "%s_Capture"
            node.description = "%s"
        }
        playback.props = {
            media.class = Audio/Source
            audio.position = [MONO]
            audio.channels = 1
            node.name     = "%s_Playback"
            node.description = "%s"
        }
        ]],
        full_internal_name,
        full_node_description,
        node.properties['node.name'],
        input_channel_name,
        full_internal_name,
        full_node_description,
        full_internal_name,
        full_node_description
    )
    -- print(module_params)
    return LocalModule("libpipewire-module-loopback", module_params)
    -- return module_params
end

function motu_m4_parse_out_serial(node_name)
    local _, _, serial = string.find(node_name, "(M4%w+)")
    return serial
end

function motu_m2_parse_out_serial(node_name)
    local _, _, serial = string.find(node_name, "(M2%w+)")
    return serial
end

function get_device_bus_id(node)
    local parent_device_id = node.properties['device.id']
    local device = om:lookup { type = "device",
        Constraint { "bound-id", "=", parent_device_id, type = "gobject" }
    }
    return device.properties['device.bus-id']
end

function get_device_index(node_name)
    device_index = node_name:gsub('.*-(%d+)$', '%1')
    if device_index then
        device_index = tonumber(device_index)+1
    end
    return device_index
end

function generic_stereo_output_devices(node, group_count, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = get_device_index(internal_name)

    local node_description  = string.format('%s %s', node.properties['node.nick'], node.properties["device.profile.description"])

    local group_index=0
    repeat
        new_devices[group_index] = generic_stereo_output_loopback_device(node, internal_name, unique_identifier, node_description, group_index, input_channel_map, output_channel_map)
        group_index=group_index+1
    until(group_index==group_count)

    return new_devices
end

function generic_input_devices(node, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = get_device_index(internal_name)

    local node_description  = string.format('%s %s', node.properties['node.nick'], node.properties["device.profile.description"])

    for channel_index, _ in ipairs(input_channel_map) do
        new_devices[channel_index] = generic_mono_input_loopback_device(node, internal_name, unique_identifier, node_description, channel_index, input_channel_map, output_channel_map)
    end
    return new_devices
end

function motu_m4_output_devices(node, group_count, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = motu_m4_parse_out_serial(internal_name)

    local node_description  =  'Motu M4'

    local group_index=0
    repeat
        new_devices[group_index] = generic_stereo_output_loopback_device(node, internal_name, unique_identifier, node_description, group_index, input_channel_map, output_channel_map)
        group_index=group_index+1
    until(group_index==group_count)

    return new_devices
end

function motu_m4_input_devices(node, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = motu_m4_parse_out_serial(internal_name)

    local node_description  =  'Motu M4'

    for channel_index, _ in ipairs(input_channel_map) do
        new_devices[channel_index] = generic_mono_input_loopback_device(node, internal_name, unique_identifier, node_description, channel_index, input_channel_map, output_channel_map)
    end
    return new_devices
end

function motu_m2_output_devices(node, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = motu_m2_parse_out_serial(internal_name)

    local node_description  =  'Motu M2'

    local group_index=0
    repeat
        new_devices[group_index] = generic_stereo_output_loopback_device(node, internal_name, unique_identifier, node_description, group_index, input_channel_map, output_channel_map)
        group_index=group_index+1
    until(group_index==group_count)

    return new_devices
end

function motu_m2_input_devices(node, group_count, input_channel_map, output_channel_map)
    local new_devices = {}

    local internal_name     = get_device_bus_id(node)
    local unique_identifier = motu_m2_parse_out_serial(internal_name)

    local node_description  =  'Motu M2'

    for channel_index, _ in ipairs(input_channel_map) do
        new_devices[channel_index] = generic_mono_input_loopback_device(node, internal_name, unique_identifier, node_description, channel_index, input_channel_map, output_channel_map)
    end
    return new_devices
end

-- Object Manager handling
om = ObjectManager {
    Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Sink", type = "pw-global" },
        Constraint { "api.alsa.card.name", "equals", "M4", type = "pw" }
    },
    Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Source", type = "pw-global" },
        Constraint { "api.alsa.card.name", "equals", "M4", type = "pw" }
    },
    Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Sink", type = "pw-global" },
        Constraint { "api.alsa.card.name", "equals", "M2", type = "pw" }
    },
    Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Source", type = "pw-global" },
        Constraint { "api.alsa.card.name", "equals", "M2", type = "pw" }
    },
    Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Source", type = "pw-global" },
        Constraint { "device.serial", "equals", "Focusrite_Scarlett_2i2_USB", type = "pw" }
    },
    Interest {
        type = "device",
    },
}

function parse_input_channels(audio_positions)
    local t = {}
    local sep = ','
    for str in string.gmatch(audio_positions, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

om:connect("object-added", function (om, node)
    local properties = node.properties
    if properties["media.class"] == "Audio/Sink"   or properties["media.class"] == "Audio/Source" then
        input_channel_map=parse_input_channels(node.properties['audio.position'])

        print(node.properties['node.name'], "added: Creating virtual wrappers")

        if "4" == node.properties['audio.channels'] then
            output_channel_map  = { "FL",   "FR",   "RL",   "RR" }
            if node.properties['node.nick'] == "M4" then
                if node.properties['media.class'] == 'Audio/Sink' then
                    output_devs[node.properties['node.name']] = motu_m4_output_devices(node, 2, input_channel_map, output_channel_map)
                elseif node.properties['media.class'] == 'Audio/Source' then
                    input_devs[node.properties['node.name']] = motu_m4_input_devices(node, input_channel_map, output_channel_map)
                end
            else
                if node.properties['media.class'] == 'Audio/Sink' then
                    output_devs[node.properties['node.name']] = generic_stereo_output_devices(node, 2, input_channel_map, output_channel_map)
                elseif node.properties['media.class'] == 'Audio/Source' then
                    input_devs[node.properties['node.name']] = generic_input_devices(node, input_channel_map, output_channel_map)
                end
            end
        elseif 2 == node.properties['audio.channels'] then
            output_channel_map  = { "FL",   "FR" }
            if node.properties['node.nick'] == "M2" then
                if node.properties['media.class'] == 'Audio/Sink' then
                    output_devs[node.properties['node.name']] = motu_m2_output_devices(node, 1, input_channel_map, output_channel_map)
                elseif node.properties['media.class'] == 'Audio/Source' then
                    input_devs[node.properties['node.name']] = motu_m2_input_devices(node, input_channel_map, output_channel_map)
                end
            else
                if node.properties['media.class'] == 'Audio/Sink' then
                    output_devs[node.properties['node.name']] = generic_stereo_output_devices(node, 1, input_channel_map, output_channel_map)
                elseif node.properties['media.class'] == 'Audio/Source' then
                    input_devs[node.properties['node.name']] = generic_input_devices(node, input_channel_map, output_channel_map)
                end
            end
        else
            print("This script does not handle your device yet")
        end
    end
end)

om:connect("object-removed", function (om, node)
    local properties = node.properties
    if properties["media.class"] == "Audio/Sink"   or properties["media.class"] == "Audio/Source" then
            print(node.properties['node.name'], "removed: Removing virtual wrappers")
            if node.properties['media.class'] == 'Audio/Sink' then
                output_devs[node.properties['node.name']]    = nil
            elseif node.properties['media.class'] == 'Audio/Source' then
                input_devs[node.properties['node.name']] = nil
        else
            print("This script does not handle your device yet")
        end
    end
end)
om:activate()
