# DrDestens LastFrameReprojectShader (DrD-LFRS)

This shader is more of a tech-demo for me, and I will look into implementing this mechanic into my shaders

This shader only requires half the amount of frames to be rendered, which could significanly boost peformance. Every second frame instead of renderung the current frame it reprojects the last frame onto the geometry of the current frame, which just requires one simple calculation and would allow to skip all other fragment shaders.

In this case, there is no performace increase, but complex shaders could simply skip their entire fsh calculations every second frame, increasing speed. 
