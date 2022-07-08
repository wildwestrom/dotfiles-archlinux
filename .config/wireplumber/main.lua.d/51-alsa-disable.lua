rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.usb-046d_0825_64303850-02" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)
