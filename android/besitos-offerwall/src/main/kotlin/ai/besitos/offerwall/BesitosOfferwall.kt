package ai.besitos.offerwall

import ai.besitos.offerwall.config.OfferwallConfig
import ai.besitos.offerwall.validation.ValidationResult
import ai.besitos.offerwall.validation.ValidationUtil
import ai.besitos.offerwall.webview.OfferwallActivity
import android.content.Context
import android.util.Log

object BesitosOfferwall {

    private const val TAG = "BesitosOfferwall"

    fun show(context: Context, config: OfferwallConfig) {
        when (val result = ValidationUtil.validate(config)) {
            is ValidationResult.Valid -> {
                OfferwallActivity.launch(context, config)
            }
            is ValidationResult.Invalid -> {
                Log.e(TAG, "Invalid config: ${result.reason}")
                throw IllegalArgumentException("BesitosOfferwall: ${result.reason}")
            }
        }
    }
}
