from django.http import HttpResponse

import json
import requests
import uuid

def slow(request):
    u = uuid.uuid4().hex

    print "Getting %s" % u

    g = requests.get("http://httpbin.org/delay/3")
    j = g.json()

    print "Got %s" % u
    
    return HttpResponse(json.dumps(j), content_type="application/json")
