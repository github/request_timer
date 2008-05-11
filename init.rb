# Put this in your layout:
#
#   <%= request_time 'Innocent text' %>
#
# Then use this bookmarklet:
#
#   javascript:alert('rendered in '+document.getElementById('_rrt').getAttribute('title'))

require 'request_timer'

config.after_initialize { RequestTimer.setup }
