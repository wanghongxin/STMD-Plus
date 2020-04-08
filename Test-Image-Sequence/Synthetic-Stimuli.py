#!/usr/bin/env python
"""Moving target over a spinning drum."""

############################
#  Import various modules  #
############################
fps = 1000.0


from VisionEgg import *
start_default_logging(); watch_exceptions()

from VisionEgg.Core import *
from VisionEgg.FlowControl import Presentation, Controller, FunctionController
from VisionEgg.MoreStimuli import *
from VisionEgg.Textures import *
import os
from math import *

# Initialize OpenGL graphics screen.
screen = get_default_screen()

#######################
#  Create the target  #
#######################

# Create an instance of the Target2D class with appropriate parameters
target = Target2D(size  = (5.0,5.0),
		color      = (0.0,0.0,0.0,1.0), # Set the target color (RGBA) black
                  orientation = 0.0)
#target_perspective = SimplePerspectiveProjection()
# Create a viewport for the target
target_viewport = Viewport(screen=screen, stimuli=[target])

#####################
#  Create the drum  #
#####################
# panorama.jpg
# Get a texture                       "panorama.jpg
filename = os.path.join(config.VISIONEGG_SYSTEM_DIR,"data","panorama.jpg")
texture = Texture(filename)

# Create an instance of SpinningDrum class
drum = SpinningDrum(texture=texture, flat = 1, shrink_texture_ok=1,position = (-150.0,120.0,0.0))
#position = (0.0,0.0,0.0), orientation = 0.0,radius = 45
#stimulus = TextureStimulus(texture = texture,
 #                        shrink_texture_ok=1)
# position = (screen.size[0]/2.0,screen.size[1]/2.0),
  #                         anchor = 'center',



# Create a perspective projection for the spinning drum
#perspective = SimplePerspectiveProjection()



# Create a viewport with this projection
drum_viewport = Viewport(screen=screen,
		                  stimuli=[drum])
# # projection = perspective,,
#stimulus = TextureStimulus(texture = texture,
#                           position = (screen.size[0]/2.0,screen.size[1]/2.0),
#                           anchor = 'center',
#                           shrink_texture_ok=1)

#drum_viewport = Viewport(screen=screen, stimuli=[stimulus])
                    
##################################################
#  Create an instance of the Presentation class  #
##################################################

# Add target_viewport last so its stimulus is drawn last. This way the
# target is always drawn after (on top of) the drum and is therefore
# visible.
p = Presentation(go_duration=(0.9,'seconds'),viewports=[drum_viewport,target_viewport])

########################
#  Define controllers  #
########################

# calculate a few variables we need
mid_x = screen.size[0]
mid_y = screen.size[1]/2.0      
max_vel = 15  # 振幅
K_2 = 2      # 正弦运动的频率因子
V_T = -250
# define target position as a function of time
def get_target_position(t):
    global mid_x, mid_y, max_vel
    return ( V_T*t+mid_x, # x
              mid_y + max_vel*sin(2.0*pi*t*K_2) ) # y


V_B = 250
Scale = 5.7
def get_drum_angle(t):
    return  (V_B/Scale)*t



# Create instances of the Controller class
target_position_controller = FunctionController(during_go_func=get_target_position)
drum_angle_controller = FunctionController(during_go_func=get_drum_angle)

#############################################################
#  Connect the controllers with the variables they control  #
#############################################################

p.add_controller(target,'position', target_position_controller )
p.add_controller(drum,'angular_position', drum_angle_controller )
#p.add_controller(drum,'position', drum_angle_controller )

#######################
#  Run the stimulus!  #
#######################

#

base_dir = '\Matlab\STMD-Plus-master\STMD-Plus-master\Test-Image-Sequence'
#if not os.path.isdir(base_dir):
#    base_dir = VisionEgg.config.VISIONEGG_SYSTEM_DIR
save_directory = os.path.join(base_dir)

#if not os.path.isdir(save_directory):
#    os.mkdir(save_directory)
#    if not os.path.isdir(save_directory):
#        print "Error: cannot make movie directory '%s'."%save_directory
#print "Saving movie to directory '%s'."%save_directory
basename = os.path.splitext(os.path.basename(sys.argv[0]))[0]
p.export_movie_go(frames_per_sec=fps,filename_base=basename,path=save_directory)

p.go()
