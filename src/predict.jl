# TODO: Change verbosity on LightGBM's side after a booster is created.
"""
    predict(estimator, X; [predict_type = 0, num_iterations = -1, verbosity = 1,
    is_row_major = false])

Return an array with the labels that the `estimator` predicts for features data `X`.

# Arguments
* `estimator::LGBMEstimator`: the estimator to use in the prediction.
* `X::Matrix{T<:Real}`: the features data.
* `predict_type::Integer`: keyword argument that controls the prediction type. `0` for normal
    scores with transform (if needed), `1` for raw scores, `2` for leaf indices.
* `num_iterations::Integer`: keyword argument that sets the number of iterations of the model to
    use in the prediction. `< 0` for all iterations.
* `verbosity::Integer`: keyword argument that controls LightGBM's verbosity. `< 0` for fatal logs
    only, `0` includes warning logs, `1` includes info logs, and `> 1` includes debug logs.
* `is_row_major::Bool`: keyword argument that indicates whether or not `X` is row-major. `true`
    indicates that it is row-major, `false` indicates that it is column-major (Julia's default).
"""
function predict(estimator::LGBMEstimator, X::Matrix{TX}; predict_type::Integer = 0,
                           num_iterations::Integer = -1, verbosity::Integer = 1,
                           is_row_major::Bool = false) where TX<:Real
    @assert(estimator.booster.handle != C_NULL, "Estimator does not contain a fitted model.")
    log_debug(verbosity, "Started predicting\n")
    prediction = LGBM_BoosterPredictForMat(estimator.booster, X, predict_type, num_iterations,
                                           is_row_major)

    return prediction
end
