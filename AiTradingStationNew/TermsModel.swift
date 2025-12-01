//
//  TermsModel.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 12/1/25.
//

import Foundation

struct TermsSection: Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

struct TermsAndConditionsModel {
    static let sections: [TermsSection] = [
        TermsSection(
            title: "1. General Information",
            body: "This application provides AI-generated trading signals for Gold ETFs. The information is provided strictly for educational and informational purposes only. Nothing in this app constitutes financial advice, investment advice, trading advice, or any other type of advice."
        ),
        TermsSection(
            title: "2. No Financial Responsibility",
            body: "The creators, developers, and distributors of this application are not responsible or liable for any trading decisions, strategies, or outcomes made by users. All trading and investment decisions are made at the sole discretion and risk of the user."
        ),
        TermsSection(
            title: "3. Risk Disclosure",
            body: "Trading in financial markets, including Gold ETFs, involves substantial risk and may not be suitable for all investors. Users may lose part or all of their invested capital. Past performance is not indicative of future results."
        ),
        TermsSection(
            title: "4. No Guarantee of Accuracy",
            body: "While we strive to provide accurate and timely information, we do not guarantee the accuracy, reliability, completeness, or timeliness of any signals or data provided by this application."
        ),
        TermsSection(
            title: "5. Independent Advice",
            body: "Users are strongly encouraged to conduct their own research and consult with licensed financial advisors before making any investment or trading decisions."
        ),
        TermsSection(
            title: "6. Limitation of Liability",
            body: "To the fullest extent permitted by law, the developers of this application disclaim all liability for any direct, indirect, incidental, or consequential damages arising from the use of or reliance on the signals or information provided by this application."
        ),
        TermsSection(
            title: "7. No Warranties",
            body: "This application is provided on an 'as-is' and 'as-available' basis. We make no warranties or representations, expressed or implied, regarding the application, including but not limited to its accuracy, reliability, or availability."
        ),
        TermsSection(
            title: "8. User Responsibility",
            body: "By using this application, you acknowledge and agree that you are solely responsible for your trading decisions and investment strategies. You agree to use the information provided strictly at your own risk."
        ),
        TermsSection(
            title: "9. Updates to Terms",
            body: "We may update or revise these Terms and Conditions at any time without prior notice. Continued use of the application after such changes constitutes acceptance of the revised Terms."
        )
    ]
}

struct PrivacySection: Identifiable {
    let id = UUID()
    let title: String
    let summary: String?
    let bullets: [String]
    let extraText: [String]
    let table: [[String]]?
}

struct PrivacyPolicyModel {
    let lastUpdated: String
    let appName: String
    let summaryPoints: [String]
    let tableOfContents: [String]
    let sections: [PrivacySection]
    
    static let full = PrivacyPolicyModel(
        lastUpdated: "September 20, 2025",
        appName: "AI Trading Station",
        summaryPoints: [
            "We process personal information you provide when using our Services (for example: email addresses, usernames).",
            "We do not process sensitive personal information or collect from third parties.",
            "We use third-party AI service providers (OpenAI and DeepSeek) for AI-powered features.",
            "Contact: waikit1986@icloud.com"
        ],
        tableOfContents: [
            "1. What information do we collect?",
            "2. How do we process your information?",
            "3. Legal bases",
            "4. When and with whom we share",
            "5. AI-based products",
            "6. How long we keep information",
            "7. How we keep your information safe",
            "8. Information from minors",
            "9. Your privacy rights",
            "10. Do-not-track",
            "11. US residents",
            "12. Other regions",
            "13. Updates",
            "14. Contact",
            "15. Review / update / delete"
        ],
        sections: [
            PrivacySection(
                title: "1. What information do we collect?",
                summary: "We collect personal information you voluntarily provide when you register, contact us, or use features of the Services.",
                bullets: ["Email addresses", "Usernames"],
                extraText: [
                    "Application data: if you use our mobile applications, we may collect additional information you choose to provide (e.g., push notification preferences).",
                    "We do not process sensitive personal information."
                ],
                table: nil
            ),
            PrivacySection(
                title: "2. How do we process your information?",
                summary: "We process information to provide, maintain, and improve the Services, communicate with you, for security and fraud prevention, and to comply with applicable law.",
                bullets: [
                    "Account creation and authentication",
                    "Customer support and correspondence",
                    "Security, fraud prevention, and safety",
                    "Providing AI-powered features (see section 5)"
                ],
                extraText: [],
                table: nil
            ),
            PrivacySection(
                title: "3. Legal bases",
                summary: "We only process your personal information when we have a lawful basis, such as your consent, performance of a contract, compliance with legal obligations, protection of vital interests, or our legitimate business interests.",
                bullets: [],
                extraText: [
                    "If you are in the EU/UK, GDPR and UK GDPR require us to explain these legal bases."
                ],
                table: nil
            ),
            PrivacySection(
                title: "4. When and with whom we share",
                summary: "We may share your information in specific situations such as business transfers, with AI service providers, analytics providers, or when legally required.",
                bullets: [
                    "Business transfers: In connection with a merger, sale, financing, or acquisition.",
                    "Offer wall: Our apps may present third-party offer walls; we may share a unique identifier with the provider to prevent fraud and credit accounts."
                ],
                extraText: [],
                table: nil
            ),
            PrivacySection(
                title: "5. AI-based products",
                summary: "Yes — we provide AI and ML powered features. We use third-party AI service providers including OpenAI and DeepSeek.",
                bullets: [],
                extraText: [
                    "Inputs and outputs are processed under our agreements with them.",
                    "You must not use our AI Products in a way that violates the terms of those providers."
                ],
                table: nil
            ),
            PrivacySection(
                title: "6. How long we keep information",
                summary: "We keep personal information only as long as necessary for the purposes described and to comply with legal obligations. When no longer needed we delete or anonymize it.",
                bullets: [],
                extraText: ["Example retention: Category A — 1 year."],
                table: nil
            ),
            PrivacySection(
                title: "7. How we keep your information safe",
                summary: "We have reasonable organizational and technical measures to protect your data.",
                bullets: [],
                extraText: [
                    "However, no system can be guaranteed 100% secure, and transmission/storage of information is at your own risk."
                ],
                table: nil
            ),
            PrivacySection(
                title: "8. Information from minors",
                summary: "We do not knowingly collect data from children under 18.",
                bullets: [],
                extraText: [
                    "If we learn we have collected such data we will delete it and deactivate the account."
                ],
                table: nil
            ),
            PrivacySection(
                title: "9. Your privacy rights",
                summary: "Depending on your jurisdiction, you may have rights to access, correct, delete, or restrict processing of your personal information.",
                bullets: [],
                extraText: [
                    "Residents of certain regions (EEA, UK, Switzerland, Canada, some US states) have specific rights; we comply with applicable laws.",
                    "If we rely on your consent you can withdraw it at any time; this will not affect past processing."
                ],
                table: nil
            ),
            PrivacySection(
                title: "10. Do-not-track",
                summary: "At present, we do not respond to browser Do-Not-Track signals because there is no uniform standard.",
                bullets: [],
                extraText: ["California law requires disclosure — we do not respond to DNT signals today."],
                table: nil
            ),
            PrivacySection(
                title: "11. US residents",
                summary: "If you are a resident of certain US states, you may have rights to request access, deletion, correction, and opt-out of certain processing.",
                bullets: [],
                extraText: ["Rights vary by state."],
                table: [
                    ["Category", "Examples", "Collected"],
                    ["A. Identifiers", "Contact details, IP address, email", "YES"],
                    ["B. Personal info (CA statute)", "Name, contact details, employment", "NO"],
                    ["C. Protected characteristics", "Race, age, gender", "NO"],
                    ["D. Commercial information", "Transactions, payment", "NO"],
                    ["E. Biometric", "Fingerprints, voiceprints", "NO"],
                    ["F. Internet activity", "Browsing history", "NO"],
                    ["G. Geolocation", "Device location", "NO"],
                    ["H. Audio / images", "Recordings, images", "NO"],
                    ["I. Professional", "Business contact, job title", "NO"],
                    ["J. Education", "Student records", "NO"],
                    ["K. Inferences", "Profiles derived", "NO"],
                    ["L. Sensitive personal info", "Special categories", "NO"]
                ]
            ),
            PrivacySection(
                title: "12. Other regions",
                summary: "Certain countries like Australia, New Zealand, South Africa, and others provide additional rights.",
                bullets: [],
                extraText: ["We comply with relevant local laws and provide contact points for complaints where applicable."],
                table: nil
            ),
            PrivacySection(
                title: "13. Updates",
                summary: "We will update this Privacy Notice as necessary.",
                bullets: [],
                extraText: [
                    "Material changes will be indicated with an updated 'Last updated' date and possibly a prominent notice."
                ],
                table: nil
            ),
            PrivacySection(
                title: "14. Contact",
                summary: "If you have questions, you may contact us by email: waikit1986@icloud.com.",
                bullets: [],
                extraText: [
                    "Postal address: ________, Lestari Apartment J-0-06, Petaling Jaya 47830, Malaysia"
                ],
                table: nil
            ),
            PrivacySection(
                title: "15. Review / update / delete",
                summary: "You may submit a data subject access request or contact us via the in-app contact form or by email.",
                bullets: [],
                extraText: [
                    "We will verify your identity before fulfilling requests and comply with applicable laws."
                ],
                table: nil
            )
        ]
    )
}
