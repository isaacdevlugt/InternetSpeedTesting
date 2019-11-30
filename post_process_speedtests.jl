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

time = range(1, stop=length(down))
ioff()
fig = figure()
plot(time, down, label="download speed")
plot(time, up, label="upload speed")
plot(time, ping, label="ping")

savefig("speedtest.png")
