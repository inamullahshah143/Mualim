import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.fonts,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Who we are?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.fonts,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'We are and always have been about amazing global citizens taking action to change our world. Forty three years ago, Chicago businessman Neal Ball started American Refugee Committee. He recruited a volunteer relief team who deployed to the Thai-Cambodian border. Even in the face of terrible tragedy, that first ARC team was characterized by their incredible energy and belief that anything was possible.\n\nNow, we\'re taking the next big step on a journey to unleash and put into action that same abundant belief. American Refugee Committee is replaced with Alight. We’re the same organization with the same people doing the same critical work – providing health care and clean water, education, shelter, protection, and economic opportunity to more than 3.5 million people in 18 countries each year. But in solidarity with the people we serve who are too often defined by a single dark moment in their lives, we’re dropping the label ‘refugee.’\n\nAlight sees and helps every person make meaningful change in the world – from displaced and marginalized communities in Africa, Asia and the Americas to…anyone, anywhere.\n\nBecoming Alight has been more than a name change. Our values, our promise, and every action that we take, and the decision we make. We believe in making things better. It is our commitment and re-envisioning of the promise we have made to the humanity we serve – the promise to “Unleash Abundance” in every single human being. Alight is a human-centered organization that serves our idealism. Our compass on this journey is the Yellow Book of Alight!\n\nWe build a meaningful life for and with the displaced. When we find people displaced from their homes, countries, or lives, our instinct may be to focus only on their basic needs. And that is essential. But it’s also not a life. A life is filled with joy, dignity, connection, and purpose. And that’s what we aim to build.\n\nWe are an open family of organizations that works closely with refugees, trafficked persons, and economic migrants, to co-design solutions that help them build full and fulfilling lives-lives that are Alight.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  color: AppTheme.fonts,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'SERVING PAKISTAN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.fonts,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Our presence in Pakistan dates back to 2002, when following the war and crisis in Afghanistan, around two million Afghans sought safety across the border. At  its peak Pakistan hosted around 5 million refugees and we were the partner of choice for the Government of Pakistan helping the displaced through provision of  protection services, healthcare, nutrition, education and building community resilience, continuing our stream of support, we are supporting the Afghan families who have faced crisis in their homeland once again after August 2021, Providing them with housing facilities, and courses to learn skills that will help them, no matter where they are. The devastating 2005 earthquake in Azad Jammu and Kashmir and Khyber Pakhtunkhwa posed new challenges, but we were there in times of need with our programs of protection and emergency shelter.  As the climate changes and the natural disasters become recurring problems, we have the experience and the expertise to best serve those affected by the elements.\n\nAlight Pakistan has completed the nation’s largest ever intervention for out-of-school children of primary school age by enrolling more than 1 million out of school children  Working on the ground with local communities and in partnership with the Government of Pakistan we seek to work out innovative solutions and sustainable strategies for enrolment and retention. Along which, we’re providing WASH and basic hygiene facilities at the schools, especially for young girls.\n\nAlight Pakistan Acknowledges that our local roots are our greatest strength – we are firmly based in Pakistan and in our work we are driven by passion to make this country better,. With our skill development programs as part of our Gaamzan Project, we aim to empower the people and to bring hope for a better, brighter future. We speak local languages, we know local communities and have strong relationship with local government and with community organizations. We work in every province of the country, reaching distant villages and urban inner communities that no other organization has reached, making sure their needs have been met. Alight Pakistan bases its relationship with disadvantaged peoples on mutual respect and a compassionate exchange of knowledge and values. We learn from each other and together we work to make things better.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  color: AppTheme.fonts,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
