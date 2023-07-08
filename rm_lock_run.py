import subprocess
import os

# 指定Flutter模块项目的名称列表
module_names = ['basic_module', 'interface_repository', 'a_module','b_module','main_module','clean_demo']

# 遍历模块项目列表，依次执行flutter pub get命令
for module_name in module_names:
    # 构建模块项目的路径
    module_path = os.path.join('./', module_name)
    
    # 运行flutter pub get命令
    os.system(f'cd {module_path} && rm pubspec.lock')