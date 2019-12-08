using PyPlot

function get_download(fname)

    words = readlines(fname)

    downloads = Any[]
    uploads = Any[]
    pings = Any[]

    for (i, word) in enumerate(words)
        
        if startswith(word, "Download:")
            tmp = split(word, r" ")
            push!(downloads, parse(Float64, tmp[length(tmp)-1]))
        end
        
        if startswith(word, "Upload:")
            tmp = split(word, r" ")
            push!(uploads, parse(Float64, tmp[length(tmp)-1]))
        end
        
        if startswith(word, "Selecting best server based on ping...")
            tmp = split(words[i+1], r" ")
            push!(pings, parse(Float64, tmp[length(tmp)-1]))
        end


    end
    return downloads, uploads, pings

end

down, up, ping = get_download("speedtests")

deleteat!(up, length(up))
deleteat!(ping, length(ping))

time = range(1, stop=length(down))
ioff()
fig, ax = subplots(3,1, sharex = true)
ax[1,1].plot(time, down, color="blue")
ax[1,1].set_ylabel("Down (Mbit/s)")
ax[2,1].plot(time, up, color="red")
ax[2,1].set_ylabel("Up (Mbit/s)")
ax[3,1].plot(time, ping, color="green")
ax[3,1].set_ylabel("Ping (ms)")
savefig("speedtest.png")
