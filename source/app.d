module app;

void main() {
    import std.stdio: writeln;
    import libloader;
    import bindbc.glfw;
    import bindbc.opengl;

    // window constants
    enum wWidth = 720;
    enum wHeight = 420;
    enum wTitle = "D/GLFW/OpenGL project";

    // --- 1. load GLFW library
    if(!load_glfw()) {
        writeln("Failed to load GLFW library!");
        return;
    }

    // --- 2. initialize GLFW
    if(!glfwInit()) {
        writeln("Failed to initialize GLFW library!");
        return;
    }
    scope(exit) { glfwTerminate(); }

    // --- 3. set default window hints and create an OpenGL context
    glfwWindowHint(GLFW_SAMPLES, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    version(OSX) {
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, true);
    }
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    // create an actual window and attach current context
    auto windowHandle = glfwCreateWindow(wWidth, wHeight, wTitle, null, null);
    if(windowHandle is null) {
        writeln("Failed to create a GLFW window!");
        return;
    }
    scope(exit) { glfwDestroyWindow(windowHandle); windowHandle = null; }

    // attach current context to GLFW window
    glfwMakeContextCurrent(windowHandle);

    // --- 3. load OpenGL library
    if(!load_opengl()) {        
        writeln("Failed to load OpenGL library!");
        return;
    }

    glViewport(0, 0, wWidth, wHeight);
    glfwSetInputMode(windowHandle, GLFW_STICKY_KEYS, true);
    glfwSwapInterval(1);

    while(!glfwWindowShouldClose(windowHandle)) {
        // PROCESS EVENTS
        glfwPollEvents();
        if(glfwGetKey(windowHandle, GLFW_KEY_Q) == GLFW_PRESS) {
            break;
        }

        // UPDATE
        // ...

        // RENDER
        glClearColor(0, 0.5, 0.5, 0);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        {
            // draw
            // ...
        }
        glfwSwapBuffers(windowHandle);
    }
}


