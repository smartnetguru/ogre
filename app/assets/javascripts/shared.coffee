window.resman = {}

window.resman.setCookie = (cname, cvalue, exdays) ->
  d = new Date()
  d.setTime(d.getTime() + (exdays*24*60*60*1000))
  expires = 'expires='+d.toUTCString()
  document.cookie = cname + '=' + cvalue + '; ' + expires

window.resman.getCookie = (cname) ->
  name = cname + '='
  ca = document.cookie.split(';')
  for i in [0...ca.length]
    c = ca[i]
    c = c.substring(1) while c.charAt(0) == ' '
    return c.substring(name.length,c.length) if (c.indexOf(name) == 0)
  return ''
