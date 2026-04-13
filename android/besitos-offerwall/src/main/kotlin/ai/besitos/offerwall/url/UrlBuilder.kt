package ai.besitos.offerwall.url

import ai.besitos.offerwall.SdkConfig
import ai.besitos.offerwall.config.OfferwallConfig
import java.net.URLEncoder

internal object UrlBuilder {

    fun build(config: OfferwallConfig): String {
        val params = buildList {
            add("userid" to config.userId)
            config.subId?.takeIf { it.isNotBlank() }?.let { add("subid" to it) }
            config.deviceId?.takeIf { it.isNotBlank() }?.let { add("device_id" to it) }
            config.idfa?.takeIf { it.isNotBlank() }?.let { add("idfa" to it) }
            config.gdfa?.takeIf { it.isNotBlank() }?.let { add("gdfa" to it) }
            config.info?.takeIf { it.isNotBlank() }?.let { add("info" to it) }
            if (config.hideHeader) add("hide_header" to "1")
            if (config.hideFooter) add("hide_footer" to "1")
        }

        val query = params.joinToString("&") { (k, v) ->
            "${encode(k)}=${encode(v)}"
        }

        return "${SdkConfig.BASE_URL}/${encode(config.partnerId)}/offers?$query"
    }

    private fun encode(value: String): String =
        URLEncoder.encode(value, "UTF-8").replace("+", "%20")
}
