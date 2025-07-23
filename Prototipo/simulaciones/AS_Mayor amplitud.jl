# Save this file as evaluate_expressions.jl

    m11 = ["0.02","0.013*cos(2*u[2])","1.1E-4*cos(2*u[3])","1.1E-4*cos(2*u[2])*cos(2*u[3])","6.5E-7*cos(2*u[4])","-2.0E-6*cos(2*u[2])*cos(2*u[4])","-6.5E-7*cos(2*u[3])*cos(2*u[4])","-6.5E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])","2.6E-6*sin(2*u[2])*cos(u[3])*sin(2*u[4])","1.4E-7*cos(2*u[5])","-4.3E-7*cos(2*u[2])*cos(2*u[5])","4.3E-7*cos(2*u[3])*cos(2*u[5])","4.3E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[5])","1.4E-7*cos(2*u[4])*cos(2*u[5])","-4.3E-7*cos(2*u[2])*cos(2*u[4])*cos(2*u[5])","-1.4E-7*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","-1.4E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","5.7E-7*sin(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","-1.1E-6*sin(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])","-5.7E-7*sin(2*u[3])*sin(u[4])*sin(2*u[5])","-5.7E-7*cos(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])"] 
    m12 = ["-2.2E-4*cos(u[2])*sin(2*u[3])","1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])","-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])","-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])","2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])"] 
    m13 = ["-0.0069*sin(u[2])","-2.6E-6*sin(u[2])*cos(2*u[4])","-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])","-5.7E-7*sin(u[2])*cos(2*u[5])","-5.7E-7*sin(u[2])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])"] 
    m14 = ["8.5E-6*cos(u[2])*sin(u[3])","-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])","-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])","-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])"] 
    m15 = ["3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])","-3.3E-6*sin(u[2])*sin(u[4])"] 
    
    m21 = ["-2.2E-4*cos(u[2])*sin(2*u[3])","1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])","-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])","-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])","2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])"] 
    m22 = ["0.033","-2.2E-4*cos(2*u[3])","-1.3E-6*cos(2*u[4])","1.3E-6*cos(2*u[3])*cos(2*u[4])","-2.9E-7*cos(2*u[5])","-8.6E-7*cos(2*u[3])*cos(2*u[5])","-2.9E-7*cos(2*u[4])*cos(2*u[5])","2.9E-7*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","1.1E-6*sin(2*u[3])*sin(u[4])*sin(2*u[5])"] 
    m23 = ["2.6E-6*sin(u[3])*sin(2*u[4])","5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])"] 
    m24 = ["8.5E-6*cos(u[3])","-1.1E-6*cos(u[3])*cos(2*u[5])","1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])"] 
    m25 = ["-3.3E-6*sin(u[3])*cos(u[4])"] 
    
    m31 = ["-0.0069*sin(u[2])","-2.6E-6*sin(u[2])*cos(2*u[4])","-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])","-5.7E-7*sin(u[2])*cos(2*u[5])","-5.7E-7*sin(u[2])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])"] 
    m32 = ["2.6E-6*sin(u[3])*sin(2*u[4])","5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])"] 
    m33 = ["0.0069","2.6E-6*cos(2*u[4])","5.7E-7*cos(2*u[5])","5.7E-7*cos(2*u[4])*cos(2*u[5])"] 
    m34 = ["1.1E-6*cos(u[4])*sin(2*u[5])"] 
    m35 = ["3.3E-6*sin(u[4])"] 
    
    m41 = ["8.5E-6*cos(u[2])*sin(u[3])","-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])","-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])","-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])"] 
    m42 = ["8.5E-6*cos(u[3])","-1.1E-6*cos(u[3])*cos(2*u[5])","1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])"] 
    m43 = ["1.1E-6*cos(u[4])*sin(2*u[5])"] 
    m44 = ["8.5E-6","-1.1E-6*cos(2*u[5])"] 
    m45 = ["0"]
    
    m51 = ["3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])","-3.3E-6*sin(u[2])*sin(u[4])"] 
    m52 = ["-3.3E-6*sin(u[3])*cos(u[4])"] 
    m53 = ["3.3E-6*sin(u[4])"]
    m54 = ["0"]
    m55 = ["3.3E-6"]
    
    c11 = ["-0.026*u[7]*sin(2*u[2])","-2.2E-4*u[7]*sin(2*u[2])*cos(2*u[3])","-2.2E-4*u[8]*sin(2*u[3])","-2.2E-4*u[8]*cos(2*u[2])*sin(2*u[3])","3.9E-6*u[7]*sin(2*u[2])*cos(2*u[4])","5.2E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])","1.3E-6*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])","1.3E-6*u[8]*sin(2*u[3])*cos(2*u[4])","1.3E-6*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])","-1.3E-6*u[9]*sin(2*u[4])","3.9E-6*u[9]*cos(2*u[2])*sin(2*u[4])","5.2E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])","-2.6E-6*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])","1.3E-6*u[9]*cos(2*u[3])*sin(2*u[4])","1.3E-6*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])","8.6E-7*u[7]*sin(2*u[2])*cos(2*u[5])","-8.6E-7*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[5])","-8.6E-7*u[8]*sin(2*u[3])*cos(2*u[5])","-8.6E-7*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])","-2.3E-6*u[10]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])","-1.1E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])","-1.1E-6*u[10]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])","8.6E-7*u[7]*sin(2*u[2])*cos(2*u[4])*cos(2*u[5])","1.1E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])","2.9E-7*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","2.9E-7*u[8]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","2.9E-7*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-2.9E-7*u[9]*sin(2*u[4])*cos(2*u[5])","8.6E-7*u[9]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])","1.1E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","-5.7E-7*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","2.9E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","2.9E-7*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","-2.9E-7*u[10]*sin(2*u[5])","8.6E-7*u[10]*cos(2*u[2])*sin(2*u[5])","-8.6E-7*u[10]*cos(2*u[3])*sin(2*u[5])","-8.6E-7*u[10]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])","-1.1E-6*u[8]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","-2.3E-6*u[7]*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])","-5.7E-7*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])","-5.7E-7*u[9]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])","1.1E-6*u[9]*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])","-1.1E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])","-1.1E-6*u[8]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])","1.1E-6*u[7]*sin(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])","-2.9E-7*u[10]*cos(2*u[4])*sin(2*u[5])","8.6E-7*u[10]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])","2.9E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])","2.9E-7*u[10]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])","-1.1E-6*u[10]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c12 = ["-0.0069*u[8]*cos(u[2])","-8.5E-6*u[9]*sin(u[2])*sin(u[3])","-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])","2.2E-4*u[7]*sin(u[2])*sin(2*u[3])","-3.2E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])","-3.2E-6*u[10]*cos(u[2])*sin(u[4])","-2.6E-6*u[8]*cos(u[2])*cos(2*u[4])","-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])","2.6E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])","-1.3E-6*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[4])","-2.6E-6*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])","-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])","-5.7E-7*u[8]*cos(u[2])*cos(2*u[5])","1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[5])","-1.7E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[5])","8.6E-7*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[5])","-2.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])","-5.7E-7*u[8]*cos(u[2])*cos(2*u[4])*cos(2*u[5])","-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])","5.7E-7*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","-2.9E-7*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])","1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])","-1.1E-6*u[7]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])","2.3E-6*u[9]*sin(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])","1.1E-6*u[7]*sin(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])","2.3E-6*u[8]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])","-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])","1.1E-6*u[10]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c13 = ["8.5E-6*u[9]*cos(u[2])*cos(u[3])","-3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])","-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])","5.2E-6*u[9]*sin(u[2])*sin(2*u[4])","2.6E-6*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])","-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])","2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])","1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])","5.7E-7*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*u[10]*sin(u[2])*sin(2*u[5])","1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])","1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c14 = ["-3.3E-6*u[10]*sin(u[2])*cos(u[4])","-3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])","-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])","2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","1.1E-6*u[9]*sin(u[2])*sin(u[4])*sin(2*u[5])"] 
    c15 = ["0"]
    
    c21 = ["0.0069*u[8]*cos(u[2])","0.013*u[6]*sin(2*u[2])","8.5E-6*u[9]*sin(u[2])*sin(u[3])","-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])","1.1E-4*u[6]*sin(2*u[2])*cos(2*u[3])","3.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])","3.3E-6*u[10]*cos(u[2])*sin(u[4])","2.6E-6*u[8]*cos(u[2])*cos(2*u[4])","-2.0E-6*u[6]*sin(2*u[2])*cos(2*u[4])","-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])","2.6E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])","-6.5E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])","-5.2E-6*u[8]*sin(u[2])*cos(u[3])*sin(2*u[4])","-2.6E-6*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])","-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])","5.7E-7*u[8]*cos(u[2])*cos(2*u[5])","-4.3E-7*u[6]*sin(2*u[2])*cos(2*u[5])","-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[5])","-1.7E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[5])","4.3E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[5])","-2.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])","5.7E-7*u[8]*cos(u[2])*cos(2*u[4])*cos(2*u[5])","-4.3E-7*u[6]*sin(2*u[2])*cos(2*u[4])*cos(2*u[5])","-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])","5.7E-7*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","-1.4E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","-1.1E-6*u[8]*sin(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","-5.7E-7*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])","1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])","1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])","2.3E-6*u[8]*sin(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])","1.1E-6*u[6]*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])","2.3E-6*u[8]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])","-5.7E-7*u[6]*sin(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])","-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])","1.1E-6*u[10]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c22 = ["4.4E-4*u[8]*sin(2*u[3])","-2.6E-6*u[8]*sin(2*u[3])*cos(2*u[4])","2.6E-6*u[9]*sin(2*u[4])","-2.6E-6*u[9]*cos(2*u[3])*sin(2*u[4])","1.7E-6*u[8]*sin(2*u[3])*cos(2*u[5])","2.3E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])","-5.7E-7*u[8]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","5.7E-7*u[9]*sin(2*u[4])*cos(2*u[5])","-5.7E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","5.7E-7*u[10]*sin(2*u[5])","1.7E-6*u[10]*cos(2*u[3])*sin(2*u[5])","1.1E-6*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])","2.3E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])","5.7E-7*u[10]*cos(2*u[4])*sin(2*u[5])","-5.7E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])"] 
    c23 = ["-8.5E-6*u[9]*sin(u[3])","-3.3E-6*u[10]*cos(u[3])*cos(u[4])","5.2E-6*u[9]*sin(u[3])*cos(2*u[4])","2.6E-6*u[8]*cos(u[3])*sin(2*u[4])","1.1E-6*u[9]*sin(u[3])*cos(2*u[5])","2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])","1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])","5.7E-7*u[8]*cos(u[3])*sin(2*u[4])*cos(2*u[5])","-1.1E-6*u[8]*sin(u[3])*cos(u[4])*sin(2*u[5])","-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c24 = ["3.3E-6*u[10]*sin(u[3])*sin(u[4])","2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])","2.3E-6*u[10]*cos(u[3])*sin(2*u[5])","1.1E-6*u[9]*sin(u[3])*cos(u[4])*sin(2*u[5])"] 
    c25 = ["0"]
    
    c31 = ["-0.0069*u[7]*cos(u[2])","-8.5E-6*u[9]*cos(u[2])*cos(u[3])","4.4E-4*u[7]*cos(u[2])*cos(2*u[3])","1.1E-4*u[6]*sin(2*u[3])","1.1E-4*u[6]*cos(2*u[2])*sin(2*u[3])","3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])","-2.6E-6*u[7]*cos(u[2])*cos(2*u[4])","-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])","-2.6E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[4])","-6.5E-7*u[6]*sin(2*u[3])*cos(2*u[4])","-6.5E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])","5.2E-6*u[9]*sin(u[2])*sin(2*u[4])","5.2E-6*u[7]*sin(u[2])*cos(u[3])*sin(2*u[4])","1.3E-6*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])","-5.7E-7*u[7]*cos(u[2])*cos(2*u[5])","1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])","1.7E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[5])","4.3E-7*u[6]*sin(2*u[3])*cos(2*u[5])","4.3E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])","2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])","-5.7E-7*u[7]*cos(u[2])*cos(2*u[4])*cos(2*u[5])","-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])","-1.4E-7*u[6]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-1.4E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])","1.1E-6*u[7]*sin(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])","2.9E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])","1.1E-6*u[10]*sin(u[2])*sin(2*u[5])","5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])","-2.3E-6*u[7]*sin(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])","-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])","5.7E-7*u[6]*cos(2*u[3])*sin(u[4])*sin(2*u[5])","5.7E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])","-2.3E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])","1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])","1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c32 = ["8.5E-6*u[9]*sin(u[3])","-2.2E-4*u[7]*sin(2*u[3])","3.3E-6*u[10]*cos(u[3])*cos(u[4])","5.2E-6*u[9]*sin(u[3])*cos(2*u[4])","1.3E-6*u[7]*sin(2*u[3])*cos(2*u[4])","-1.1E-6*u[9]*sin(u[3])*cos(2*u[5])","-8.6E-7*u[7]*sin(2*u[3])*cos(2*u[5])","2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])","1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])","2.9E-7*u[7]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])","-2.3E-6*u[9]*cos(u[3])*sin(u[4])*sin(2*u[5])","-1.1E-6*u[7]*cos(2*u[3])*sin(u[4])*sin(2*u[5])","-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c33 = ["-5.2E-6*u[9]*sin(2*u[4])","-1.1E-6*u[9]*sin(2*u[4])*cos(2*u[5])","-1.1E-6*u[10]*sin(2*u[5])","-1.1E-6*u[10]*cos(2*u[4])*sin(2*u[5])"] 
    c34 = ["3.3E-6*u[10]*cos(u[4])","2.3E-6*u[10]*cos(u[4])*cos(2*u[5])","-1.1E-6*u[9]*sin(u[4])*sin(2*u[5])"] 
    c35 = ["0"]
    
    c41 = ["8.5E-6*u[8]*cos(u[2])*cos(u[3])","-8.5E-6*u[7]*sin(u[2])*sin(u[3])","3.3E-6*u[10]*sin(u[2])*cos(u[4])","3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])","5.2E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])","-2.6E-6*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])","5.2E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])","6.5E-7*u[6]*sin(2*u[4])","-5.2E-6*u[8]*sin(u[2])*sin(2*u[4])","-2.0E-6*u[6]*cos(2*u[2])*sin(2*u[4])","-6.5E-7*u[6]*cos(2*u[3])*sin(2*u[4])","-6.5E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])","2.6E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])","-1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[5])","1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[5])","-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])","1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])","-5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])","1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])","1.4E-7*u[6]*sin(2*u[4])*cos(2*u[5])","-1.1E-6*u[8]*sin(u[2])*sin(2*u[4])*cos(2*u[5])","-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])","-1.4E-7*u[6]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])","2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])","-1.1E-6*u[7]*cos(u[2])*cos(u[4])*sin(2*u[5])","1.1E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])","2.9E-7*u[6]*sin(2*u[3])*cos(u[4])*sin(2*u[5])","2.9E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])","2.3E-6*u[8]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])","-5.7E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])"] 
    c42 = ["-8.5E-6*u[8]*sin(u[3])","-3.3E-6*u[10]*sin(u[3])*sin(u[4])","-5.2E-6*u[8]*sin(u[3])*cos(2*u[4])","-1.3E-6*u[7]*sin(2*u[4])","1.3E-6*u[7]*cos(2*u[3])*sin(2*u[4])","1.1E-6*u[8]*sin(u[3])*cos(2*u[5])","2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])","-1.1E-6*u[8]*sin(u[3])*cos(2*u[4])*cos(2*u[5])","-2.9E-7*u[7]*sin(2*u[4])*cos(2*u[5])","2.9E-7*u[7]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])","2.3E-6*u[10]*cos(u[3])*sin(2*u[5])","-5.7E-7*u[7]*sin(2*u[3])*cos(u[4])*sin(2*u[5])","2.3E-6*u[8]*cos(u[3])*sin(u[4])*sin(2*u[5])"] 
    c43 = ["-3.3E-6*u[10]*cos(u[4])","2.6E-6*u[8]*sin(2*u[4])","2.3E-6*u[10]*cos(u[4])*cos(2*u[5])","5.7E-7*u[8]*sin(2*u[4])*cos(2*u[5])"] 
    c44 = ["2.3E-6*u[10]*sin(2*u[5])"] 
    c45 = ["0"]
    
    c51 = ["-3.3E-6*u[9]*sin(u[2])*cos(u[4])","-3.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])","-3.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])","-3.3E-6*u[7]*cos(u[2])*sin(u[4])","-3.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])","2.3E-6*u[9]*sin(u[2])*cos(u[4])*cos(2*u[5])","2.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])","1.1E-6*u[6]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])","2.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])","2.3E-6*u[7]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])","5.7E-7*u[6]*sin(2*u[3])*sin(u[4])*cos(2*u[5])","5.7E-7*u[6]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])","1.4E-7*u[6]*sin(2*u[5])","-1.1E-6*u[8]*sin(u[2])*sin(2*u[5])","-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[5])","-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(2*u[5])","4.3E-7*u[6]*cos(2*u[3])*sin(2*u[5])","4.3E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])","-1.7E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[5])","1.4E-7*u[6]*cos(2*u[4])*sin(2*u[5])","-1.1E-6*u[8]*sin(u[2])*cos(2*u[4])*sin(2*u[5])","-4.3E-7*u[6]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])","-1.4E-7*u[6]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])","-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])","5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])","-1.1E-6*u[8]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])","5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])","-1.1E-6*u[7]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c52 = ["-3.3E-6*u[8]*cos(u[3])*cos(u[4])","3.3E-6*u[9]*sin(u[3])*sin(u[4])","-2.3E-6*u[8]*cos(u[3])*cos(u[4])*cos(2*u[5])","-2.3E-6*u[9]*sin(u[3])*sin(u[4])*cos(2*u[5])","-1.1E-6*u[7]*sin(2*u[3])*sin(u[4])*cos(2*u[5])","-2.9E-7*u[7]*sin(2*u[5])","-2.3E-6*u[9]*cos(u[3])*sin(2*u[5])","-8.6E-7*u[7]*cos(2*u[3])*sin(2*u[5])","-2.9E-7*u[7]*cos(2*u[4])*sin(2*u[5])","2.9E-7*u[7]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])","1.1E-6*u[8]*sin(u[3])*sin(2*u[4])*sin(2*u[5])"] 
    c53 = ["3.3E-6*u[9]*cos(u[4])","-2.3E-6*u[9]*cos(u[4])*cos(2*u[5])","5.7E-7*u[8]*sin(2*u[5])","5.7E-7*u[8]*cos(2*u[4])*sin(2*u[5])"] 
    c54 = ["-1.1E-6*u[9]*sin(2*u[5])"]
    c55 = ["0"]
    

#exprs = [m11,m12,m13,m14,m15]
#exprs = [m21,m22,m23,m24,m25]
#exprs = [m31,m32,m33,m34,m35]
#exprs = [m41,m42,m43,m44,m45]
#exprs = [m51,m52,m53,m54,m55]

#exprs = [c11,c12,c13,c14]
#exprs = [c21,c22,c23,c24]
#exprs = [c31,c32,c33,c34]
#exprs = [c41,c42,c43,c44]
exprs = [c51,c52,c53,c54]


function evaluate_expressions(exprs, values)
    results = Vector{Float64}[]
    for val in values
        u1, u2,u3,u4,u5,u6,u7,u8,u9,u10 = val
        result = [eval(Meta.parse(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
            expr,
            #"Ixs" => string(Ixs),
            #"Iys" => string(Iys),
            #"Izs" => string(Izs),
            #"Ixg" => string(Ixg),
            #"Iyg" => string(Iyg),
            #"Izs" => string(Izs),  
            #r"\bIx\b" => string(Ix), 
            #r"\bIy\b" => string(Iy), 
            #r"\bIz\b" => string(Iz), 
            "u[1]" => string(u1)), 
            "u[2]" => string(u2)), 
            "u[3]" => string(u3)), 
            "u[4]" => string(u4)), 
            "u[5]" => string(u5)), 
            "u[6]" => string(u6)), 
            "u[7]" => string(u7)), 
            "u[8]" => string(u8)), 
            "u[9]" => string(u9)), 
            "u[10]" => string(u10)) ) )))))))))) for expr in exprs]
        push!(results, result)
    end
    return results
end

# Evaluate the expressions

maxs = Float64[]

for i in 1:4
global resultss = evaluate_expressions(exprs[i], sol.u)

for j in 1:length(exprs[i])
    push!(maxs,maximum(abs.([x[j] for x in resultss])))
end

global maxmax = maximum(maxs)

global fsimple = ""

for j in  eachindex(exprs[i]) 
    if maxs[j]/maxmax > 0.01
       global  fsimple *= "+" * exprs[i][j]
    end
end
println("c",i ," =" , fsimple, "\n")
global fsimple = ""
resultss = Vector{Float64}[]
global maxs = Float64[]

maxmax = 0

end

