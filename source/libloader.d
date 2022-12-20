module libloader;

import bindbc.glfw: GLFWSupport, loadGLFW, glfwSupport;
import bindbc.opengl: GLSupport, loadOpenGL;

import std.stdio: writefln;

/++
    Loads a shared GLFW library

    Returns:
        `true` upon success, `false` otherwise
+/
bool load_glfw() {   
    // set default dll lookup path for Windows
    version(Windows) { 
        import bindbc.loader: setCustomLoaderSearchPath;
        setCustomLoaderSearchPath("libs"); 
    }

    // attempt to load GLFW
    auto ret = loadGLFW();
    if(ret != glfwSupport) {   
        writefln(
            ret == GLFWSupport.noLibrary ? "No GLFW library found!" : 
            ret == GLFWSupport.badLibrary ? "A newer version of GLFW is needed. Please, upgrade!" : 
            "Unknown error! Could not load OpenGL library!"
        );
        return false;
    }
    writefln("GLFW successfully loaded, version: %s", ret);
    
    return true;
}

/++ 
    Loads OpenGL library
    
    Returns:
        `true` upon success, `false` otherwise
+/
bool load_opengl() {
    auto ret = loadOpenGL();

    // error checking
    switch(ret) with(GLSupport) {
        case gl46:
        case gl45:
        case gl44:
        case gl43:
        case gl42:
        case gl41:
        case gl40:
        case gl33:
        case gl32:
        case gl31:
        case gl30:
            writefln("OpenGL successfully loaded, version: %s", ret);
            return true;
        case badLibrary:
            writefln("The version of the GLFW library on your system is too low. Please upgrade.");
            break;
        case noContext:
            writefln("Create an OpenGL context before attempting to load OpenGL!");
            break;
        case noLibrary:
            writefln("OpenGL library not found!");
            break;
        default:
            import bindbc.loader: errors;
            writefln("Unknown error! Could not load OpenGL library! Error code: %s", ret);
            writefln("Other errors: %s", errors);
            break;
    }

    return false;
}



