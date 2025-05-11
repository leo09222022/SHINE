package com.emerlet.db;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

public class LibreTranslate {
	public static String translate(String text, String targetLang) throws IOException {
		String apiUrl = "https://translate.argosopentech.com/translate";


		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");
		conn.setDoOutput(true);

		String safeText = text.replace("\\", "\\\\") // 역슬래시
				.replace("\"", "\\\"") // 큰따옴표
				.replace("\n", " ") // 줄바꿈 제거
				.replace("\r", " ").replace("\t", " "); // 탭 제거

		String payload = String.format("{\"q\": \"%s\", \"source\": \"ko\", \"target\": \"%s\", \"format\": \"text\"}",
				safeText, targetLang);
		System.out.println("📤 요청 payload = " + payload);

		try (OutputStream os = conn.getOutputStream()) {
			os.write(payload.getBytes("utf-8"));
		}

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null)
			sb.append(line);

		// {"translatedText":"Translated value"} 형식의 응답에서 값만 추출
		String result = sb.toString();

		int start = result.indexOf(":\"") + 2;
		int end = result.indexOf("\"", start);
		if (start > 1 && end > start) {
			return result.substring(start, end);
		} else {
			throw new IOException("번역 응답 파싱 실패: " + result);
		}
	}
}