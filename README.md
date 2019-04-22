> t0sic_billing

DO NOT USE IT IF YOU DON*T KNOW WHAT YOU ARE DOING


Do not rename the resource, it won't work if you do.

# [ Installation ]
- Drag and drop it in your resource folder
- add it to your server cfg. 
- Replace all the esx_billing events.
 
> To fetch received invoices you do following.
```lua
    exports["t0sic_billing"]:FetchBillings()
```

#

> To send invoices you do following.
```lua
    exports["t0sic_billing"]:SendBilling()
```

#

> To view sent invoices you do following.
```lua
    exports["t0sic_billing"]:SentBillings()
```

# [ Preview ]
- https://streamable.com/1locp

# [ Credits ]
- credits to gamz, zeaqy and hazze for doing some lua parts.
