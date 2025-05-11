package com.emerlet.db;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class GCPTranslate {
	private static String apiKey;

	public static void setApiKey(String key) {
		apiKey = key;
	}

	public static String translate(String text, String targetLang) throws Exception {
		if (apiKey == null || apiKey.isEmpty()) {
			throw new IllegalStateException("API 키가 설정되지 않았습니다.");
		}

		String encodedText = URLEncoder.encode(text, StandardCharsets.UTF_8);
		String urlStr = String.format(
				"https://translation.googleapis.com/language/translate/v2?key=%s&q=%s&source=ko&target=%s&format=text",
				apiKey, encodedText, targetLang);

		URL url = new URL(urlStr);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		StringBuilder response = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			response.append(line);
		}

		String result = response.toString();

		// "translatedText":"실제값" 추출
		String marker = "\"translatedText\":";
		int start = result.indexOf(marker);
		if (start == -1)
			throw new RuntimeException("translatedText 필드가 응답에 없습니다.");

		start = result.indexOf("\"", start + marker.length()) + 1;
		int end = result.indexOf("\"", start);
		if (start <= 0 || end <= start)
			throw new RuntimeException("번역 결과 파싱 실패: " + result);

		return result.substring(start, end);
	}
}
