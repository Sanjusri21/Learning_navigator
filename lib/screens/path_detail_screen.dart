import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/learning_path.dart';

class PathDetailScreen extends StatefulWidget {
  final LearningPath path;
  const PathDetailScreen({super.key, required this.path});

  @override
  State<PathDetailScreen> createState() => _PathDetailScreenState();
}

class _PathDetailScreenState extends State<PathDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['Intro', 'Skills', 'Roadmap', 'Resources', 'FAQ', 'Careers'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Open URL in external browser
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  // ── Roadmap data per path ──────────────────────────────────────
  List<Map<String, String>> _getRoadmap() {
    final title = widget.path.title;
    if (title == 'Web Development') {
      return [
        {'title': 'HTML & CSS Fundamentals', 'desc': 'Learn the building blocks of the web: structure, layout, and styling.', 'time': '4 Weeks'},
        {'title': 'JavaScript Essentials', 'desc': 'Master variables, functions, DOM manipulation, and async programming.', 'time': '6 Weeks'},
        {'title': 'React Framework', 'desc': 'Build dynamic UIs with components, hooks, and state management.', 'time': '5 Weeks'},
        {'title': 'Node.js & Express', 'desc': 'Create server-side APIs and handle routing and middleware.', 'time': '4 Weeks'},
        {'title': 'Databases (SQL & NoSQL)', 'desc': 'Work with MySQL and MongoDB for data storage.', 'time': '3 Weeks'},
        {'title': 'Deployment & DevOps', 'desc': 'Deploy apps to cloud platforms with CI/CD pipelines.', 'time': '2 Weeks'},
      ];
    }
    if (title == 'Artificial Intelligence') {
      return [
        {'title': 'Python Basics', 'desc': 'Start with Python syntax, data types, and control flow.', 'time': '4 Weeks'},
        {'title': 'Mathematics for AI', 'desc': 'Linear algebra, statistics, and calculus fundamentals.', 'time': '4 Weeks'},
        {'title': 'Machine Learning', 'desc': 'Supervised and unsupervised learning algorithms.', 'time': '6 Weeks'},
        {'title': 'Deep Learning', 'desc': 'Neural networks, CNNs, and RNNs with TensorFlow.', 'time': '5 Weeks'},
        {'title': 'NLP', 'desc': 'Natural Language Processing and text classification.', 'time': '4 Weeks'},
      ];
    }
    if (title == 'Data Science') {
      return [
        {'title': 'Python for Data Science', 'desc': 'NumPy, Pandas, and data wrangling basics.', 'time': '4 Weeks'},
        {'title': 'Statistics & Probability', 'desc': 'Descriptive stats, distributions, and hypothesis testing.', 'time': '5 Weeks'},
        {'title': 'Data Visualization', 'desc': 'Matplotlib, Seaborn, and Plotly for charts.', 'time': '3 Weeks'},
        {'title': 'Machine Learning', 'desc': 'Regression, classification, and clustering models.', 'time': '5 Weeks'},
        {'title': 'SQL for Data Science', 'desc': 'Query databases and join large datasets efficiently.', 'time': '3 Weeks'},
        {'title': 'Capstone Project', 'desc': 'Real-world end-to-end data science project.', 'time': '4 Weeks'},
      ];
    }
    if (title == 'Graphic Design') {
      return [
        {'title': 'Design Theory', 'desc': 'Color, typography, layout, and visual hierarchy basics.', 'time': '3 Weeks'},
        {'title': 'Adobe Photoshop', 'desc': 'Photo editing, compositing, and retouching.', 'time': '4 Weeks'},
        {'title': 'Adobe Illustrator', 'desc': 'Vector art, logos, and icon design.', 'time': '4 Weeks'},
        {'title': 'UI/UX Design', 'desc': 'Wireframing, prototyping, and user research.', 'time': '4 Weeks'},
        {'title': 'Brand Identity', 'desc': 'Creating cohesive brand systems and style guides.', 'time': '3 Weeks'},
      ];
    }
    if (title == 'Data Structures & Algorithms') {
      return [
        {'title': 'Arrays & Strings', 'desc': 'Core operations, two-pointer, and sliding window.', 'time': '3 Weeks'},
        {'title': 'Linked Lists & Stacks', 'desc': 'Singly/doubly linked lists, stacks, and queues.', 'time': '3 Weeks'},
        {'title': 'Trees & Graphs', 'desc': 'BST, DFS, BFS, and graph algorithms.', 'time': '5 Weeks'},
        {'title': 'Sorting & Searching', 'desc': 'Merge sort, quick sort, binary search.', 'time': '3 Weeks'},
        {'title': 'Dynamic Programming', 'desc': 'Memoization, tabulation, and classic DP problems.', 'time': '5 Weeks'},
        {'title': 'System Design Basics', 'desc': 'Scalability, caching, and load balancing.', 'time': '4 Weeks'},
        {'title': 'Interview Practice', 'desc': 'Timed problem solving and mock interviews.', 'time': '4 Weeks'},
        {'title': 'Competitive Programming', 'desc': 'Advanced techniques for coding competitions.', 'time': '5 Weeks'},
      ];
    }
    if (title == 'Data Analytics') {
      return [
        {'title': 'Excel Fundamentals', 'desc': 'Formulas, pivot tables, and dashboards.', 'time': '3 Weeks'},
        {'title': 'SQL Queries', 'desc': 'SELECT, JOIN, GROUP BY, and subqueries.', 'time': '4 Weeks'},
        {'title': 'Power BI Dashboards', 'desc': 'Data modeling, DAX, and interactive reports.', 'time': '4 Weeks'},
        {'title': 'Tableau Visualizations', 'desc': 'Charts, maps, and story points.', 'time': '3 Weeks'},
        {'title': 'Python for Analytics', 'desc': 'Pandas, Matplotlib for data analysis.', 'time': '4 Weeks'},
      ];
    }
    if (title == 'Mobile App Development') {
      return [
        {'title': 'Dart Language', 'desc': 'Dart syntax, OOP, and async programming.', 'time': '3 Weeks'},
        {'title': 'Flutter Basics', 'desc': 'Widgets, layouts, and navigation.', 'time': '4 Weeks'},
        {'title': 'State Management', 'desc': 'Provider, Riverpod, and BLoC patterns.', 'time': '3 Weeks'},
        {'title': 'Firebase Integration', 'desc': 'Auth, Firestore, and cloud storage.', 'time': '4 Weeks'},
        {'title': 'Publishing Apps', 'desc': 'Deploy to Google Play Store and Apple App Store.', 'time': '2 Weeks'},
      ];
    }
    if (title == 'Cyber Security') {
      return [
        {'title': 'Networking Basics', 'desc': 'TCP/IP, DNS, firewalls, and network protocols.', 'time': '4 Weeks'},
        {'title': 'Linux Security', 'desc': 'Linux command line, permissions, and hardening.', 'time': '4 Weeks'},
        {'title': 'Cryptography', 'desc': 'Encryption, hashing, and PKI fundamentals.', 'time': '3 Weeks'},
        {'title': 'Ethical Hacking', 'desc': 'Penetration testing, vulnerability scanning.', 'time': '5 Weeks'},
        {'title': 'Incident Response', 'desc': 'Threat detection, forensics, and remediation.', 'time': '4 Weeks'},
      ];
    }
    return [
      {'title': 'Getting Started', 'desc': 'Introduction and setup.', 'time': '2 Weeks'},
    ];
  }

  // ── Resources data per path ────────────────────────────────────
  List<Map<String, String>> _getResources() {
    final title = widget.path.title;
    if (title == 'Web Development') {
      return [
        {'title': 'The Odin Project', 'source': 'Free full-stack curriculum', 'url': 'https://www.theodinproject.com'},
        {'title': 'MDN Web Docs', 'source': 'Mozilla – Official Web Reference', 'url': 'https://developer.mozilla.org'},
        {'title': 'FreeCodeCamp', 'source': 'Free – Hands-on coding challenges', 'url': 'https://www.freecodecamp.org'},
        {'title': 'Full Stack Open', 'source': 'University of Helsinki', 'url': 'https://fullstackopen.com'},
      ];
    }
    if (title == 'Artificial Intelligence') {
      return [
        {'title': 'fast.ai', 'source': 'Free practical deep learning course', 'url': 'https://www.fast.ai'},
        {'title': 'Google ML Crash Course', 'source': 'Google – Free ML course', 'url': 'https://developers.google.com/machine-learning/crash-course'},
        {'title': 'Kaggle Learn', 'source': 'Free micro-courses in ML & AI', 'url': 'https://www.kaggle.com/learn'},
        {'title': 'Deep Learning Book', 'source': 'Free online textbook', 'url': 'https://www.deeplearningbook.org'},
      ];
    }
    if (title == 'Data Science') {
      return [
        {'title': 'Kaggle', 'source': 'Free datasets and competitions', 'url': 'https://www.kaggle.com'},
        {'title': 'DataCamp', 'source': 'Interactive data science courses', 'url': 'https://www.datacamp.com'},
        {'title': 'Towards Data Science', 'source': 'Medium – Community articles', 'url': 'https://towardsdatascience.com'},
        {'title': 'Python Data Science Handbook', 'source': 'Free O\'Reilly book online', 'url': 'https://jakevdp.github.io/PythonDataScienceHandbook'},
      ];
    }
    if (title == 'Data Analytics') {
      return [
        {'title': 'Google Data Analytics Certificate', 'source': 'Coursera – Google', 'url': 'https://www.coursera.org/professional-certificates/google-data-analytics'},
        {'title': 'Microsoft Power BI Docs', 'source': 'Official documentation', 'url': 'https://docs.microsoft.com/en-us/power-bi'},
        {'title': 'Mode SQL Tutorial', 'source': 'Free interactive SQL tutorial', 'url': 'https://mode.com/sql-tutorial'},
        {'title': 'Tableau Public', 'source': 'Free Tableau learning resources', 'url': 'https://public.tableau.com'},
      ];
    }
    if (title == 'Mobile App Development') {
      return [
        {'title': 'Flutter Docs', 'source': 'Official Flutter documentation', 'url': 'https://flutter.dev/docs'},
        {'title': 'Dart Language Tour', 'source': 'Official Dart documentation', 'url': 'https://dart.dev/guides/language/language-tour'},
        {'title': 'Flutter Cookbook', 'source': 'Practical Flutter recipes', 'url': 'https://docs.flutter.dev/cookbook'},
        {'title': 'Firebase Docs', 'source': 'Official Firebase documentation', 'url': 'https://firebase.google.com/docs'},
      ];
    }
    if (title == 'Cyber Security') {
      return [
        {'title': 'TryHackMe', 'source': 'Free cyber security learning platform', 'url': 'https://tryhackme.com'},
        {'title': 'Hack The Box', 'source': 'Hands-on hacking labs', 'url': 'https://www.hackthebox.com'},
        {'title': 'OWASP', 'source': 'Open Web Application Security Project', 'url': 'https://owasp.org'},
        {'title': 'Cybrary', 'source': 'Free security courses', 'url': 'https://www.cybrary.it'},
      ];
    }
    if (title == 'Data Structures & Algorithms') {
      return [
        {'title': 'LeetCode', 'source': 'DSA practice problems', 'url': 'https://leetcode.com'},
        {'title': 'NeetCode', 'source': 'Free DSA roadmap & solutions', 'url': 'https://neetcode.io'},
        {'title': 'GeeksForGeeks', 'source': 'Comprehensive DSA articles', 'url': 'https://www.geeksforgeeks.org'},
        {'title': 'Visualgo', 'source': 'Visual algorithm animations', 'url': 'https://visualgo.net'},
      ];
    }
    if (title == 'Graphic Design') {
      return [
        {'title': 'Canva Design School', 'source': 'Free design tutorials', 'url': 'https://www.canva.com/learn'},
        {'title': 'Adobe Tutorials', 'source': 'Official Adobe learning hub', 'url': 'https://helpx.adobe.com/tutorials.html'},
        {'title': 'Behance', 'source': 'Design portfolio inspiration', 'url': 'https://www.behance.net'},
        {'title': 'Figma Learn', 'source': 'Free UI/UX design resources', 'url': 'https://help.figma.com/hc/en-us'},
      ];
    }
    return [
      {'title': 'YouTube', 'source': 'Free video tutorials', 'url': 'https://www.youtube.com'},
      {'title': 'Coursera', 'source': 'Online courses from top universities', 'url': 'https://www.coursera.org'},
    ];
  }

  // ── Career data per path ───────────────────────────────────────
  List<Map<String, String>> _getCareers() {
    final title = widget.path.title;
    if (title == 'Web Development') {
      return [
        {'title': 'Frontend Developer', 'salary': '\$65k – \$120k'},
        {'title': 'Backend Developer', 'salary': '\$75k – \$130k'},
        {'title': 'Full Stack Developer', 'salary': '\$80k – \$145k'},
        {'title': 'UI/UX Engineer', 'salary': '\$70k – \$125k'},
      ];
    }
    if (title == 'Artificial Intelligence') {
      return [
        {'title': 'ML Engineer', 'salary': '\$100k – \$180k'},
        {'title': 'AI Research Scientist', 'salary': '\$120k – \$200k'},
        {'title': 'Data Scientist', 'salary': '\$90k – \$160k'},
        {'title': 'NLP Engineer', 'salary': '\$100k – \$170k'},
      ];
    }
    if (title == 'Data Science') {
      return [
        {'title': 'Data Scientist', 'salary': '\$85k – \$155k'},
        {'title': 'ML Engineer', 'salary': '\$95k – \$170k'},
        {'title': 'Data Engineer', 'salary': '\$90k – \$160k'},
        {'title': 'Research Analyst', 'salary': '\$65k – \$110k'},
      ];
    }
    if (title == 'Data Analytics') {
      return [
        {'title': 'Data Analyst', 'salary': '\$55k – \$100k'},
        {'title': 'Business Intelligence Analyst', 'salary': '\$65k – \$115k'},
        {'title': 'Reporting Analyst', 'salary': '\$50k – \$90k'},
        {'title': 'Product Analyst', 'salary': '\$70k – \$120k'},
      ];
    }
    if (title == 'Mobile App Development') {
      return [
        {'title': 'Flutter Developer', 'salary': '\$70k – \$130k'},
        {'title': 'Android Developer', 'salary': '\$75k – \$135k'},
        {'title': 'iOS Developer', 'salary': '\$80k – \$145k'},
        {'title': 'Mobile Architect', 'salary': '\$100k – \$160k'},
      ];
    }
    if (title == 'Cyber Security') {
      return [
        {'title': 'Security Analyst', 'salary': '\$70k – \$130k'},
        {'title': 'Penetration Tester', 'salary': '\$80k – \$150k'},
        {'title': 'SOC Analyst', 'salary': '\$60k – \$110k'},
        {'title': 'CISO', 'salary': '\$140k – \$250k'},
      ];
    }
    if (title == 'Data Structures & Algorithms') {
      return [
        {'title': 'Software Engineer', 'salary': '\$80k – \$160k'},
        {'title': 'Backend Engineer', 'salary': '\$85k – \$165k'},
        {'title': 'Systems Architect', 'salary': '\$110k – \$190k'},
        {'title': 'Algorithm Engineer', 'salary': '\$100k – \$175k'},
      ];
    }
    if (title == 'Graphic Design') {
      return [
        {'title': 'Graphic Designer', 'salary': '\$45k – \$85k'},
        {'title': 'UI Designer', 'salary': '\$60k – \$110k'},
        {'title': 'Brand Designer', 'salary': '\$55k – \$100k'},
        {'title': 'Creative Director', 'salary': '\$80k – \$140k'},
      ];
    }
    return [
      {'title': 'Specialist', 'salary': '\$50k – \$100k'},
    ];
  }

  // ── FAQ data per path ──────────────────────────────────────────
  List<Map<String, String>> _getFAQs() {
    final title = widget.path.title;
    if (title == 'Web Development') {
      return [
        {'q': 'How long does it take to become a web developer?', 'a': 'Typically 6–12 months with consistent daily practice.'},
        {'q': 'Do I need a Computer Science degree?', 'a': 'No — skills and a strong portfolio matter more than a degree.'},
        {'q': 'Which language should I learn first?', 'a': 'HTML and CSS are the foundation. Then move to JavaScript.'},
        {'q': 'Is web development a good career in 2026?', 'a': 'Yes, demand continues to grow with millions of job openings worldwide.'},
      ];
    }
    if (title == 'Artificial Intelligence') {
      return [
        {'q': 'Do I need a math background for AI?', 'a': 'Basic linear algebra and statistics help, but you can learn as you go.'},
        {'q': 'Which programming language is used in AI?', 'a': 'Python is the dominant language for AI and ML development.'},
        {'q': 'How long to learn AI fundamentals?', 'a': 'Around 6–9 months of dedicated study.'},
      ];
    }
    if (title == 'Mobile App Development') {
      return [
        {'q': 'Flutter vs React Native — which to learn?', 'a': 'Flutter is recommended for beginners due to its consistent UI and growing community.'},
        {'q': 'Can I publish apps without a Mac?', 'a': 'Android apps can be published without a Mac. iOS requires a Mac for final submission.'},
        {'q': 'Is Flutter good for jobs?', 'a': 'Yes, Flutter demand has increased significantly as companies adopt cross-platform development.'},
      ];
    }
    return [
      {'q': 'How long does this path take?', 'a': 'It depends on your pace, but ${widget.path.duration} on average.'},
      {'q': 'Is prior experience required?', 'a': 'No — this path is designed to take you from beginner to job-ready.'},
      {'q': 'Will I get a certificate?', 'a': 'Yes, a completion certificate is awarded after finishing all modules.'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.path;
    final roadmap = _getRoadmap();
    final totalSteps = roadmap.length;
    final completedSteps = (path.progress * totalSteps).floor();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 210,
            pinned: true,
            backgroundColor: const Color(0xFF5B5FEF),
            leading: const BackButton(color: Colors.white),
            title: const Text(
              'Learning Path',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4158D0), Color(0xFF9B59B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 95, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: path.iconEmoji == '<>'
                                ? const Icon(Icons.code, color: Colors.white, size: 28)
                                : Text(path.iconEmoji,
                                    style: const TextStyle(fontSize: 26)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                path.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline,
                                      color: Colors.white70, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${path.students ~/ 1000},${(path.students % 1000).toString().padLeft(3, '0')} students',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.access_time,
                                      color: Colors.white70, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    path.duration,
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your Progress',
                            style: TextStyle(color: Colors.white, fontSize: 13)),
                        Text(
                          '${(path.progress * 100).toInt()}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: path.progress,
                        minHeight: 7,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // ── INTRO TAB ─────────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _InfoCard(
                  title: 'About This Path',
                  child: Text(
                    path.description,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  title: 'Path Overview',
                  child: Column(
                    children: [
                      _OverviewRow(Icons.schedule, 'Duration', path.duration),
                      _OverviewRow(Icons.code, 'Skills', '${path.skills} skills covered'),
                      _OverviewRow(Icons.people, 'Students',
                          '${path.students.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} enrolled'),
                      _OverviewRow(Icons.bar_chart, 'Progress',
                          '${(path.progress * 100).toInt()}% completed'),
                    ],
                  ),
                ),
              ],
            ),

            // ── SKILLS TAB ────────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: path.whatYouLearn.asMap().entries.map((entry) {
                final i = entry.key;
                final skill = entry.value;
                final isLearned = i < completedSteps;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: isLearned
                        ? Border.all(color: Colors.green.shade300, width: 1.5)
                        : null,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          isLearned ? Colors.green : const Color(0xFFEEF0FF),
                      child: Icon(
                        isLearned ? Icons.check : Icons.workspace_premium,
                        color: isLearned ? Colors.white : const Color(0xFF5B5FEF),
                        size: 20,
                      ),
                    ),
                    title: Text(skill,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      isLearned ? 'Completed ✓' : 'Beginner • ~2 Weeks',
                      style: TextStyle(
                          color: isLearned ? Colors.green : Colors.grey,
                          fontSize: 12),
                    ),
                  ),
                );
              }).toList(),
            ),

            // ── ROADMAP TAB ───────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '$completedSteps of $totalSteps steps completed',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                ...roadmap.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isCompleted = index < completedSteps;
                  final isCurrent = index == completedSteps;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoadmapDetailScreen(
                            title: item['title']!,
                            desc: item['desc']!,
                            time: item['time']!,
                            stepNumber: index + 1,
                            isCompleted: isCompleted,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: isCurrent
                            ? Border.all(
                                color: const Color(0xFF5B5FEF), width: 1.5)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: isCompleted
                                ? Colors.green
                                : isCurrent
                                    ? const Color(0xFF5B5FEF)
                                    : Colors.grey.shade200,
                            child: Icon(
                              isCompleted
                                  ? Icons.check
                                  : isCurrent
                                      ? Icons.play_arrow
                                      : Icons.lock_outline,
                              color: isCompleted || isCurrent
                                  ? Colors.white
                                  : Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Step ${index + 1}: ${item['title']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isCompleted
                                      ? 'Completed ✓'
                                      : isCurrent
                                          ? 'In Progress — Tap to continue'
                                          : 'Locked — Complete previous steps',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isCompleted
                                        ? Colors.green
                                        : isCurrent
                                            ? const Color(0xFF5B5FEF)
                                            : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '⏱ ${item['time']}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 14, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),

            // ── RESOURCES TAB ─────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Tap any resource to open in your browser',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                ..._getResources().map((res) {
                  return GestureDetector(
                    onTap: () => _launchURL(res['url']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF0FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.open_in_new,
                                color: Color(0xFF5B5FEF), size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  res['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF5B5FEF),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  res['source']!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),

            // ── FAQ TAB ───────────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: _getFAQs().map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ExpansionTile(
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(
                      faq['q']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          faq['a']!,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // ── CAREERS TAB ───────────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Career paths after completing this program',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                ..._getCareers().map((career) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF0FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.work_outline,
                              color: Color(0xFF5B5FEF), size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                career['title']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                career['salary']!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.trending_up,
                            color: Colors.green, size: 20),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Overview Row Helper ────────────────────────────────────────────────────────
class _OverviewRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _OverviewRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF5B5FEF)),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}

// ── Roadmap Detail Screen ──────────────────────────────────────────────────────
class RoadmapDetailScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final int stepNumber;
  final bool isCompleted;

  const RoadmapDetailScreen({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.stepNumber,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B5FEF),
        foregroundColor: Colors.white,
        title: Text('Step $stepNumber'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green.shade50 : const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isCompleted ? Colors.green : const Color(0xFF5B5FEF),
                ),
              ),
              child: Text(
                isCompleted ? '✓ Completed' : '▶️ In Progress / Upcoming',
                style: TextStyle(
                  color: isCompleted ? Colors.green : const Color(0xFF5B5FEF),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 18, color: Color(0xFF5B5FEF)),
                      const SizedBox(width: 8),
                      Text('Estimated Duration: $time',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B5FEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Back to Roadmap',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Info Card ─────────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}