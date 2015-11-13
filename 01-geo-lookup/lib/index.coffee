fs = require 'fs'


GEO_FIELD_MIN = 0
GEO_FIELD_MAX = 1
GEO_FIELD_COUNTRY = 2


exports.ip2long = (ip) ->
  ip = ip.split '.', 4
  return +ip[0] * 16777216 + +ip[1] * 65536 + +ip[2] * 256 + +ip[3]


gindex = {}
ip_ranges_positions = []
exports.load = ->
  data = fs.readFileSync "#{__dirname}/../data/geo.txt", 'utf8'
  data = data.toString().split '\n'

  for line in data when line
    line = line.split '\t'
    # GEO_FIELD_MIN, GEO_FIELD_MAX, GEO_FIELD_COUNTRY
    gindex[line[0]] = [+line[0], +line[1], line[3]]
    ip_ranges_positions.push +line[0]

  ip_ranges_positions.sort(sortNumbers)


sortNumbers = (i,j) ->
  return i-j


findClosest = (iplong) ->
  max_pos = ip_ranges_positions.length - 1

  min_pos = 0
  while(true)
    if(max_pos - min_pos> 1 && ip_ranges_positions[parseInt((max_pos + min_pos) / 2)] > iplong)
      max_pos = parseInt((max_pos + min_pos) / 2)
      continue;

    if(max_pos - min_pos> 1 && ip_ranges_positions[parseInt((max_pos + min_pos) / 2)] <= iplong)
      min_pos = parseInt((max_pos + min_pos) / 2)
      continue

    if(gindex[ip_ranges_positions[min_pos]][1] >= iplong && gindex[ip_ranges_positions[min_pos]][0] <= iplong )
      return ip_ranges_positions[min_pos]

    return null


normalize = (row) -> country: row[GEO_FIELD_COUNTRY]


exports.lookup = (ip) ->
  return -1 unless ip

  find = this.ip2long ip

  closest = findClosest find
  if(closest == null)
    return null

  return normalize gindex[closest]

