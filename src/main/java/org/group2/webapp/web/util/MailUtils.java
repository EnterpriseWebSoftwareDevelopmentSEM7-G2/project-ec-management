/**
 * 
 */
package org.group2.webapp.web.util;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.group2.webapp.entity.Claim;
import org.group2.webapp.entity.User;

/**
 * @author Dam Cao Son
 * @Contact kunedo1104@gmail.com
 *
 */
public class MailUtils {

	private static Properties config = null;
	private static Session mailSs;

	static {
		if (config == null) {
			config = new Properties();
			config.put("mail.smtp.auth", "true");
			config.put("mail.smtp.starttls.enable", "true");
			config.put("mail.smtp.host", "smtp.gmail.com");
			config.put("mail.smtp.port", "587");

			mailSs = Session.getInstance(config, new OurAuthentication());
		}
	}

	public static void sendClaimNewsForCoordinators(Claim claim, List<User> users) {
		StringBuilder sb = new StringBuilder();
		sb.append("You have new EC claim from student!\n");
		sb.append("<a href='localhost:8080'>Click here to see</a>");
		for (User user : users) {
			sendMail(user.getEmail(), "New EC Claim", sb.toString());
		}
	}

	public static void sendClaimNewsForStudent(Claim claim) {
		StringBuilder sb = new StringBuilder();
		sb.append("Your EC claim has final decision!\n");
		sb.append("<a href='localhost:8080'>Click here to see</a>");

		sendMail(claim.getUser().getEmail(), "EC Claim", sb.toString());
	}

	public static void sendMail(String to, String subject, String content) {
		new Thread(new Runnable() {

			@Override
			public void run() {
				try {
					Message msg = new MimeMessage(mailSs);
					msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
					msg.setSubject(subject);
					msg.setContent(content, "text/html");
					Transport.send(msg);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}).start();

	}

	public static void main(String[] args) {
		MailUtils.sendMail("sondcgc00681@fpt.edu.vn", "Title", "<a href='#'>Click vao day</a>");
	}

}

class OurAuthentication extends Authenticator {
	private static final String USERNAME = "systemec2017@gmail.com";
	private static final String PASSWORD = "-ec12356789";

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(USERNAME, PASSWORD);
	}
}
