import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  double _rating = 3.0;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulating a network request
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you! Feedback submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState!.reset();
      setState(() => _rating = 3.0);
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Exact background gradient colors matching your profile screen
    const scaffoldBackgroundGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 246, 247, 250), // white Top
          Color.fromARGB(255, 134, 144, 255), // light Blue Bottom
        ],
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: false,
      // Styled AppBar matching the background application color scheme
      appBar: AppBar(
        title: const Text(
          'Share Your Feedback with us...',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(
            255, 61, 48, 237), // Matches the deep top navy color
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration:
            scaffoldBackgroundGradient, // Applies the profile background theme
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'We value your input!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),

                // Name Input Field
                TextFormField(
                  controller: _nameController,
                  enabled: !_isLoading,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Name', Icons.person),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter your name'
                      : null,
                ),
                const SizedBox(height: 18),

                // Email Input Field
                TextFormField(
                  controller: _emailController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email', Icons.email),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(v)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Slider Number Indicators
                const Text(
                  'How would you rate your experience?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      int num = index + 1;
                      bool isSelected = _rating.round() == num;
                      return Expanded(
                        child: Text(
                          '$num',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.grey[400],
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Custom Colored Slider Track
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.grey[700],
                  label: _rating.round().toString(),
                  onChanged:
                      _isLoading ? null : (v) => setState(() => _rating = v),
                ),
                const SizedBox(height: 18),

                // Comments Field
                TextFormField(
                  controller: _commentsController,
                  enabled: !_isLoading,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Your Comments', null),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please share your thoughts'
                      : null,
                ),
                const SizedBox(height: 36),

                // Conditional Resized Button state
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Colors.blueAccent)))
                    : Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _submitFeedback,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .blueAccent, // Contrasts nicely against the dark backdrop
                              foregroundColor: const Color(0xFF0F172A),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text('Submit Feedback',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dark card-style input box decorator matching your dark theme fields
  InputDecoration _buildInputDecoration(String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      prefixIcon: icon != null ? Icon(icon, color: Colors.blueAccent) : null,
      filled: true,
      fillColor: const Color.fromARGB(255, 238, 242, 247).withValues(alpha: 0.4),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5)),
    );
  }
}
