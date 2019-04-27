__precompile__()

module LightGBM

using Libdl

# Macro to load a library
macro checked_lib(libname, path)
    if Libdl.dlopen_e(path) == C_NULL
        error("Unable to load \n\n$libname ($path)\n\nPlease re-run Pkg.build(package), and restart Julia.")
    end
    quote
        const $(esc(libname)) = $path
    end
end

@checked_lib LGBM_library "/usr/local/lib/lib_lightgbm.so"

# function __init__()
#    global LGBM_library
#    if !haskey(ENV, "LIGHTGBM_PATH")
#       error("Environment variable LIGHTGBM_PATH not found. ",
#          "Set this variable to point to the LightGBM directory prior to loading LightGBM.jl ",
#          "(e.g. `ENV[\"LIGHTGBM_PATH\"] = \"../LightGBM\"`).")
#    else
#       LGBM_library = find_library(["lib_lightgbm.so", "lib_lightgbm.dll", "lib_lightgbm.dylib"], [ENV["LIGHTGBM_PATH"]])
#       if LGBM_library == ""
#          error("Could not open the LightGBM library at $(ENV["LIGHTGBM_PATH"]). ",
#             "Set this variable to point to the LightGBM directory prior to loading LightGBM.jl ",
#             "(e.g. `ENV[\"LIGHTGBM_PATH\"] = \"../LightGBM\"`).")
#       end
#    end
# end

using Compat

include("wrapper.jl")
include("estimators.jl")
include("utils.jl")
include("fit.jl")
include("predict.jl")
include("cv.jl")
include("search_cv.jl")

export fit, predict, cv, search_cv, savemodel, loadmodel
export LGBMEstimator, LGBMRegression, LGBMBinary, LGBMMulticlass

end # module LightGBM
