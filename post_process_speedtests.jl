using PyPlot

function get_download(fname)

    words = readlines(fname)

    downloads = []
    uploads = []
    pings = []

    for (i, word) in enumerate(words)
       
        if startswith(word, "Testing download")
            tmp = split(words[i+1], r" ")
            push!(downloads, parse(Float64, tmp[length(tmp)-1]))
        
        elseif startswith(word, "Testing upload")
            tmp = split(words[i+1], r" ")
            push!(uploads, parse(Float64, tmp[length(tmp)-1]))
        
        elseif startswith(word, "Hosted by")
            tmp = split(word, r" ")
            push!(pings, parse(Float64, tmp[length(tmp)-1]))
       
        end
        
    end
    return downloads, uploads, pings

end

down, up, ping = get_download("speedtests")

x = range(0, stop=length(down)-1)
time = readlines("time_series")

fig, ax = subplots(3,1, sharex = true)
ax[1,1].plot(time, down, color="blue")
ax[1,1].set_ylabel("Down (Mbs)")
ax[2,1].plot(time, up, color="red")
ax[2,1].set_ylabel("Up (Mbs)")
ax[3,1].plot(time, ping, color="green")
ax[3,1].set_ylabel("Ping (ms)")
plt.xticks(x, time, rotation="vertical")
plt.tight_layout()
savefig("speedtest.png", format="png", dpi=1000)
