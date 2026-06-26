class LearningPath {
  final String title;
  final String subtitle;
  final String iconEmoji;
  final int students;
  final String duration;
  final int skills;
  final double progress;
  final List<String> whatYouLearn;
  final String description;

  LearningPath({
    required this.title,
    required this.subtitle,
    required this.iconEmoji,
    required this.students,
    required this.duration,
    required this.skills,
    required this.progress,
    required this.whatYouLearn,
    required this.description,
  });
}

final List<LearningPath> samplePaths = [
  LearningPath(
    title: 'Web Development',
    subtitle: 'Master HTML, CSS, JavaScript, and React',
    iconEmoji: '<>',
    students: 15420,
    duration: '6 months',
    skills: 6,
    progress: 0.65,
    description:
        'Web Development is the process of creating and maintaining websites and web applications. It involves designing user interfaces, developing functionality, and managing databases. Web developers use technologies like HTML, CSS, JavaScript, and various frameworks to build responsive and interactive websites. The field is divided into Frontend Development (user interface), Backend Development (server-side logic), and Full Stack Development (both frontend and backend). Web development is essential for businesses, e-commerce, education, and online services.',
    whatYouLearn: ['HTML5', 'CSS3', 'JavaScript', 'React', 'Node.js', 'Databases'],
  ),
  LearningPath(
    title: 'Artificial Intelligence',
    subtitle: 'Learn AI, Machine Learning, and Deep Learning',
    iconEmoji: '🧠',
    students: 12850,
    duration: '9 months',
    skills: 5,
    progress: 0.20,
    description:
        'Artificial Intelligence is a branch of computer science that enables machines to perform tasks that normally require human intelligence. AI systems can learn from data, recognize patterns, make decisions, and solve problems. Technologies such as Machine Learning, Deep Learning, and Natural Language Processing are major parts of AI. AI is used in virtual assistants, recommendation systems, self-driving cars, healthcare, and robotics.',
    whatYouLearn: ['Python', 'ML Algorithms', 'Neural Networks', 'TensorFlow', 'NLP'],
  ),
  LearningPath(
    title: 'Data Science',
    subtitle: 'Learn Python, statistics and data analysis',
    iconEmoji: '📊',
    students: 18200,
    duration: '7 months',
    skills: 6,
    progress: 0.30,
    description:
        'Data Science is the field of extracting meaningful insights and knowledge from large amounts of data. It combines statistics, programming, mathematics, and domain expertise to analyze data and support decision-making. Data scientists collect, clean, process, and visualize data to identify trends and patterns. Popular tools include Python, R, SQL, and machine learning libraries.',
    whatYouLearn: ['Python', 'Pandas', 'Statistics', 'Visualization', 'SQL', 'ML'],
  ),
  LearningPath(
    title: 'Graphic Design',
    subtitle: 'Master visual communication',
    iconEmoji: '🎨',
    students: 9500,
    duration: '5 months',
    skills: 5,
    progress: 0.0,
    description:
        'Graphic Design is the art of creating visual content to communicate ideas and messages effectively. It involves designing logos, posters, brochures, social media content, websites, and branding materials. Graphic designers use software such as Adobe Photoshop, Illustrator, and Canva to create attractive visuals. The field combines creativity, typography, color theory, and layout design.',
    whatYouLearn: ['Photoshop', 'Illustrator', 'Typography', 'Color Theory', 'Canva'],
  ),
  LearningPath(
    title: 'Data Structures & Algorithms',
    subtitle: 'Master coding interviews',
    iconEmoji: '<>',
    students: 16500,
    duration: '8 months',
    skills: 8,
    progress: 0.0,
    description:
        'Data Structures and Algorithms is a fundamental area of computer science focused on organizing data efficiently and solving problems effectively. Data structures such as arrays, linked lists, stacks, queues, trees, and graphs help store and manage data. Algorithms are step-by-step procedures used to perform tasks and solve computational problems.',
    whatYouLearn: ['Arrays', 'Trees', 'Graphs', 'Sorting', 'Dynamic Programming', 'Queues', 'Stacks', 'Recursion'],
  ),
  LearningPath(
    title: 'Data Analytics',
    subtitle: 'Turn data into insights',
    iconEmoji: '📈',
    students: 14700,
    duration: '5 months',
    skills: 5,
    progress: 0.40,
    description:
        'Data Analytics is the process of examining, transforming, and interpreting data to discover useful information and support decision-making. Analysts use statistical methods and visualization tools to identify trends, patterns, and business opportunities. Common tools include Excel, SQL, Power BI, Tableau, and Python.',
    whatYouLearn: ['Excel', 'Power BI', 'SQL', 'Tableau', 'Python'],
  ),
  LearningPath(
    title: 'Mobile App Development',
    subtitle: 'Build Android and iOS apps',
    iconEmoji: '📱',
    students: 11200,
    duration: '7 months',
    skills: 5,
    progress: 0.45,
    description:
        'Mobile Development is the process of creating applications for smartphones and tablets. Developers build apps for platforms such as Android and iOS using technologies like Flutter, React Native, Kotlin, and Swift. Mobile applications provide services such as communication, entertainment, education, shopping, and productivity.',
    whatYouLearn: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'State Management'],
  ),
  LearningPath(
    title: 'Cyber Security',
    subtitle: 'Protect systems and networks',
    iconEmoji: '🛡️',
    students: 8900,
    duration: '8 months',
    skills: 5,
    progress: 0.0,
    description:
        'Cyber Security is the practice of protecting computer systems, networks, and data from cyber threats and unauthorized access. It involves implementing security measures to prevent hacking, malware, phishing, and data breaches. Cyber security professionals use tools and techniques to identify vulnerabilities and secure digital assets.',
    whatYouLearn: ['Networking', 'Ethical Hacking', 'Linux', 'Cryptography', 'Pen Testing'],
  ),
];