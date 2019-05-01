__precompile__()

module LightGBM

using Libdl

const LGBM_library = find_library(["lib_lightgbm.so", "lib_lightgbm.dll", "lib_lightgbm.dylib"], [ENV["LIGHTGBM_PATH"]])

function __init__()
   global LGBM_library
   if !haskey(ENV, "LIGHTGBM_PATH")
      error("Environment variable LIGHTGBM_PATH not found. ",
         "Set this variable to point to the LightGBM directory prior to loading LightGBM.jl ",
         "(e.g. `ENV[\"LIGHTGBM_PATH\"] = \"../LightGBM\"`).")
   else
      slib = find_library(["lib_lightgbm.so", "lib_lightgbm.dll", "lib_lightgbm.dylib"], [ENV["LIGHTGBM_PATH"]])
      if slib == ""
         error("Could not open the LightGBM library at $(ENV["LIGHTGBM_PATH"]). ",
            "Set this variable to point to the LightGBM directory prior to loading LightGBM.jl ",
            "(e.g. `ENV[\"LIGHTGBM_PATH\"] = \"../LightGBM\"`).")
      end
   end
end

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
