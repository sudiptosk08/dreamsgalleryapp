import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';

class English extends StatefulWidget {
  @override
  _EnglishState createState() => _EnglishState();
}

class _EnglishState extends State<English> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "General",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "This Terms and Conditions supersede any prior terms and conditions or any general or specific terms and conditions of the Customer. Every product order placed on the Site,"
            " presupposes the acceptance by the Customer of the Terms and Conditions and the Customer shall be bound by these Terms and Conditions."
            "In addition, the general use of the Site is subject to this Terms & Conditions of Use."
            " Dream Gallery reserves the right to vary and/or alter these Terms and Conditions at any "
            "time without notice and without assigning any reason there of and accordingly the revised version shall apply.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Product",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Dreams Gallery products are handcrafted therefore we cannot guarantee that the"
            " product you see online and the purchased product will be exactly the same though every effort is made for it to be a very close match. "
            "Also We have made every effort to display as accurately as possible the "
            "colors of our products that appear on the website. However, due to monitor discrepancies of"
            " persona computer/laptop/tablet/hand-held devices/mobile, we cannot guarantee that your display of color will be accurate"
            "If a product ordered at Dreams Gallery website is not as described, "
            "customer's responsibility is to return it immediately to the delivery "
            "agent without tearing of the void sticker attached on the product package."
            "The illustrations weights and dimensions of the products (goods) listed in the catalogue are purely"
            " informative unless otherwise stated as binding. The products sold from the Site are solely for"
            " your use and not for re-sale.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6),
          child: Text(
            "Cancellation Policy",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Please make sure that you cancel your order (if required) while our customer "
            "service agent calls you for confirming your delivery address. Please note that "
            "once you have reconfirmed the order over the phone,"
            " you cannot cancel the order once the delivery agent reaches your delivery address with the product.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Pricing and Price Reductions/Corrections",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Dreams Gallery guarantees the price as of the purchase day will remain valid till delivery date. "
            "That means after the completion of your ordering process if the price increases, "
            "you will not be charged for price increment;"
            " and no adjustment shall be made if any price decreases from the order price."
            "For product(s) pricing issues all rights are reserved by Dreams Gallery. "
            "Dreams Gallery can change or close the offer(s) at any time without any prior notification."
            "Listed prices include tax/Vat unless stated otherwise. However, delivery charge is not included in the listed price.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Order Acceptance/Confirmation",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Customer will be asked to provide information for order verification; including but not limited to phone number and address, order ID before the order is accepted."
            "In order to avoid any fraud with credit or debit cards, we reserve the right to obtain validation of customer payment details before providing the product and to verify the personal information shared with us. This verification can take the shape of an identity, place of residence or banking information check. Failing to answer any following demand may automatically cause the cancellation of the order within 2 working days. We reserve the right to proceed to direct cancellation of an order for which we suspect a risk of fraudulent use of credit or debit card."
            "In case of any error or technical issue, Dreams Gallery reserves the right to refuse or cancel any order. In such an event Dreams Gallery will either contact you with further instructions and/or may cancel your order and notify you of such cancellation. Dreams Gallery reserves the right to refuse or cancel any such orders irrespective of the fact whether the order had been confirmed and your credit card been charged.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Product Availability and Limitations",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Given the popularity and/or supply constraints of some of our products, Dreams Gallery may have to limit the number of products available for the customers to purchase. Dreams Gallery reserves the right to change quantities available at any time. There might be cases when an order cannot be processed for various reasons. We reserve the right to refuse or cancel any order for any reason at any given time and in such an event if payment has been successfully made by the Customer then customer shall get the refund accordingly.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Inaccuracy Disclaimer",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "From time to time there may be information on our website that contains typographical errors, inaccuracies, or omissions that may relate to product descriptions, pricing, and availability. Dreams Gallery reserves the right to correct any errors, inaccuracies or omissions and to change or update information at any time without prior notice (including after you have submitted your order). We Endeavour to present the most recent, most accurate, and most reliable information on our website at all times. However, there may be occasions when some of the information featured on Dreams Gallery website may contain incomplete data, typographical errors, or inaccuracies. Any errors are wholly unintentional and we apologies if erroneous information is reflected in merchandise price, item availability, or in any way affect your individual order. Please be aware that we present our content 'as is' and make no claims to its accuracy, either expressed or implied. We reserve the right to amend errors or to update product information at any time without prior notice.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Limitation of Liability",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Dreams Gallery's maximum liability shall be limited to the amount that the Customer has paid for any particular product."
            "Dreams Gallery does not accept any liability for any indirect loss, consequential loss/damage, loss of data, loss of income or profit, damage to property, force majeure situations, failure/delay due to technical errors and unavoidable circumstances and/or claims of third parties for the use of the Site and any product purchased.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "Applicable law",
            style: KTextStyle.bodyText3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0, bottom: 6.0, right: 25.0, top: 6.0),
          child: Text(
            "The Terms and Conditions are governed by, and construed in accordance with, the laws of Bangladesh.",
            style: KTextStyle.bodyText4.copyWith(
              color: Colors.grey[700],
              wordSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
